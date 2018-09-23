//
//  MovieStackLayout.swift
//  MovieSelector
//
//  Created by Cagdas Timurlenk on 21.09.2018.
//  Copyright © 2018 CodeAndDreams. All rights reserved.
//

import UIKit
protocol MovieStackLayoutDelegate : class {
    func removeMovie(_ flowLayout: MovieStackLayout, indexPath: IndexPath , withLike : Bool)
}
class MovieStackLayout: UICollectionViewLayout {
  
    private let maxMovePercantage : CGFloat = 0.3
    private var panGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer()
    
    private let duration: TimeInterval = 0.15
    
    weak var delegate : MovieStackLayoutDelegate?
    
  override func prepare() {
    super.prepare()
    
    panGestureRecognizer.addTarget(self, action: #selector(handlePan(gestureRecognizer:)))
    collectionView?.addGestureRecognizer(panGestureRecognizer)
  }
    
    //return top and top -1 cell to deque stack from top item.
    typealias CellForIndexPath = (cell: UICollectionViewCell, indexPath: IndexPath)
    
    private var topCellForIndexPath: CellForIndexPath? {
        let lastItem = collectionView?.numberOfItems(inSection: 0) ?? 0
        let indexPath = IndexPath(item: lastItem - 1, section: 0)
        guard let cell = collectionView?.cellForItem(at: indexPath) else { return nil }
        return (cell: cell, indexPath: indexPath)
    }
    
    private var bottomCellForIndexPath: CellForIndexPath? {
        guard let numItems = collectionView?.numberOfItems(inSection: 0), numItems > 1 else { return nil }
        
        let indexPath = IndexPath(item: numItems - 2, section: 0)
        
        guard let cell = collectionView?.cellForItem(at: indexPath) else { return nil }
        
        return (cell: cell, indexPath: indexPath)
    }
  
  fileprivate func indexPathsForElementsInRect(_ rect: CGRect) -> [IndexPath] {
    var indexPaths: [IndexPath] = []
    
    if let numItems = collectionView?.numberOfItems(inSection: 0), numItems > 0 {
      for i in 0...numItems-1 {
        indexPaths.append(IndexPath(item: i, section: 0))
      }
    }
    
    return indexPaths
  }
  
  @objc func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
    let translation = gestureRecognizer.translation(in: collectionView)
    
    let xOffset = translation.x
    let xMaxOffset = (collectionView?.frame.width ?? 0) * maxMovePercantage
    
    switch gestureRecognizer.state {
    case .changed:
        // move top card as we scroll..
        if let topCard = topCellForIndexPath {
            topCard.cell.transform = CGAffineTransform(translationX: xOffset, y: 0)
        }
        
        if let bottomCard = bottomCellForIndexPath {
            
            let draggingScale = 0.7 + (abs(xOffset) / (collectionView?.frame.width ?? 1) * 0.7)
            let scale = draggingScale > 1 ? 1 : draggingScale
            
            bottomCard.cell.transform = CGAffineTransform(scaleX: scale, y: scale)
            
            bottomCard.cell.alpha = scale / 2
        }
    case .ended:
        // check if absolute offset bigger than maxoffsett defined.
        if abs(xOffset) > xMaxOffset {
            if let topCard = topCellForIndexPath {
                //if xoffset < 0 then swipe left else swipe right..
                animateAndRemove(left: xOffset < 0, cell: topCard.cell, completion: {
                    [weak self] in

                    guard let `self` = self else { return }
                    
                    self.delegate?.removeMovie(self, indexPath: topCard.indexPath, withLike: xOffset > 0)
                    
                })
            }
            
            if let bottomCard = bottomCellForIndexPath {
                animateIntoPosition(cell: bottomCard.cell)
            }
        } else {
            if let topCard = topCellForIndexPath {
                
                //move topcard back to original state as identiy.
                animateIntoPosition(cell: topCard.cell)
            }
        }
    default:
        break
    }
  }
    
    private func animateIntoPosition(cell: UICollectionViewCell) {
        
        UIView.animate(withDuration: duration) {
            cell.transform = CGAffineTransform.identity
            cell.alpha = 1
        }
    }
    
    private func animateAndRemove(left: Bool, cell: UICollectionViewCell, completion: (() -> ())?) {
        
        let screenWidth = UIScreen.main.bounds.width
        
        UIView.animate(withDuration: duration, animations: {
            
            let xTranslateOffscreen = CGAffineTransform(translationX: left ? -screenWidth : screenWidth, y: 0)
            cell.transform = xTranslateOffscreen
        }) { (completed) in
            completion?()
        }
    }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    
    // Here we can just target the top two items on the stack
    let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
    
    attributes.frame = collectionView?.bounds ?? .zero
    
    var isNotTop = false
    if let numItems = collectionView?.numberOfItems(inSection: 0), numItems > 0 {
      isNotTop = indexPath.row != numItems - 1
    }
    
    attributes.alpha = isNotTop ? 0 : 1
    
    return attributes
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let indexPaths = indexPathsForElementsInRect(rect)
    let layoutAttributes = indexPaths.map { layoutAttributesForItem(at: $0) }
      .filter { $0 != nil }.map { $0! }
    
    return layoutAttributes
    
  }
}


//
//  MovieCollectionViewCell.swift
//  MovieSelector
//
//  Created by Cagdas Timurlenk on 21.09.2018.
//  Copyright © 2018 CodeAndDreams. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieCollectionViewCell: UICollectionViewCell {

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let voteLabel = UILabel()
    private let cardView = UIView()
    
    
    var movieViewModel:MovieList.ViewModel.MovieViewModel?{
        didSet{
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        //  backgroundType = .light(priceMovement: .up)
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
//        http://image.tmdb.org/t/p/w400//nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(cardView)
        cardView.layer.cornerRadius = 4
        cardView.backgroundColor = .white
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowRadius = 4
        cardView.layer.shadowOffset = CGSize(width: -1, height: 2)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addConstraints([
            NSLayoutConstraint(item: cardView, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 0.95, constant: 0.0),
            NSLayoutConstraint(item: cardView, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .width, multiplier: 0.95, constant: 0.0),
            NSLayoutConstraint(item: cardView, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: cardView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
            ])
        
        cardView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(voteLabel)
        voteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addConstraints([
            NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: cardView, attribute: .leading, multiplier: 1.0, constant: CGFloat.horizontalOffset),
            NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: cardView, attribute: .trailing, multiplier: 1.0, constant: -CGFloat.horizontalOffset),
            NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: cardView, attribute: .top, multiplier: 1.0, constant: 0)
            ])
        
        contentView.addConstraints([
            NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: imageView, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1.0, constant: 10.0)
            ])
        
        contentView.addConstraints([
            NSLayoutConstraint(item: voteLabel, attribute: .centerX, relatedBy: .equal, toItem: titleLabel, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: voteLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0),
            NSLayoutConstraint(item: voteLabel, attribute: .bottom, relatedBy: .equal, toItem: cardView, attribute: .bottom, multiplier: 1.0, constant: -CGFloat.outerVerticalOffset)
            ])
    }
    
    
    func updateUI()
    {
        imageView.af_cancelImageRequest()
        let placeholderImage = UIImage(named: "moviePlaceHolder.png")
        let urlString = "\(Constants.MovieApiCred.imageBase)\(movieViewModel?.posterPath ?? "")"
        
        if let url = URL(string: urlString)
        {
            imageView.af_setImage(withURL: url, placeholderImage: placeholderImage)
        }
        else
        {
            imageView.image = placeholderImage
        }
        
        titleLabel.text = movieViewModel?.title
        voteLabel.text = "\(movieViewModel?.releaseDate ?? "") - \(movieViewModel?.voteAverage ?? 0.0)"
    }

}

private extension CGFloat {
    static let widthMultiplier: CGFloat = 0.8
    static let outerVerticalOffset: CGFloat = 10
    static let horizontalOffset: CGFloat = 0
    static let innerVerticalOffset: CGFloat = 10
}

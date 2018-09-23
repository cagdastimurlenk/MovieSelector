//
//  MovieRouter.swift
//  MovieSelector
//
//  Created by Cagdas Timurlenk on 21.09.2018.
//  Copyright © 2018 CodeAndDreams. All rights reserved.
//

import Foundation
import UIKit
protocol MovieRouter {
    func showSelectedMovie(_ model: MovieList.ViewModel.MovieViewModel)
    func showMoviePage()
}

extension MovieRouter where Self: UIViewController{

    func showMoviePage()
    {
        show(storyboard: .main, identifier: MovieViewController.identifier, showMenuOnNavigationBar: false) { T in
            //let vc = T as! MovieViewController
            
        }
    }
    func showSelectedMovie(_ model: MovieList.ViewModel.MovieViewModel){
                show(storyboard: .main,
                     identifier: MovieViewController.identifier,
                     configure: { T in
                        let vc = T as! MovieViewController
                        vc.model = model
                })
    }
    
//    func showSelectedMovie(_ model: MovieList.ViewModel..ViewModel.NewsViewModel){
//        show(storyboard: .menu,
//             identifier: NewsDetailViewController.identifier,
//             configure: { T in
//                let vc = T as! NewsDetailViewController
//                vc.model = model
//        })
//    }
    
//    func presentSelectedMovie(){
//
//        present(storyboard:.menu,
//                identifier: MovieListViewController.identifier,
//                animate:false,
//                modalPresentationStyle:UIModalPresentationStyle ,
//                addInNavigationController: false,
//                configure : { (controller) in
//                    let filterVC = controller as? ElectricianFilterViewController
//                    filterVC?.delegate = self as? ElectricianFilterViewControllerDelegate
//        })
//    }
}

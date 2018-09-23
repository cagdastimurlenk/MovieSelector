//
//  MovieListPresenter.swift
//  MovieSelector
//
//  Created by Cagdas Timurlenk on 21.09.2018.
//  Copyright © 2018 CodeAndDreams. All rights reserved.
//

import Foundation

protocol MovieListPresentationLogic {
    func presentMovieList(_ response: MovieList.Response)
}

class MovieListPresenter: MovieListPresentationLogic{
    
    weak var viewController: MovieListDisplayLogic?
    
    func presentMovieList(_ response: MovieList.Response) {
        viewController?.displayMovieList(response.getViewModel())
    }
}

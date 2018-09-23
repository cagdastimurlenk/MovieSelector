//
//  MoviePresenter.swift
//  MovieSelector
//
//  Created by Cagdas Timurlenk on 21.09.2018.
//  Copyright © 2018 CodeAndDreams. All rights reserved.
//

import Foundation
protocol MoviePresentationLogic {
    func presentMovieDetail(_ response: MovieDetail.Response)
}

class MoviePresenter: MoviePresentationLogic{
    
    weak var viewController: MovieDisplayLogic?
    
    func presentMovieDetail(_ response: MovieDetail.Response) {
        viewController?.displayMovieDetail(response.getViewModel())
    }
}

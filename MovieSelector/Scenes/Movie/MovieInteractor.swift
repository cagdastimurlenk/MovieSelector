//
//  MovieInteractor.swift
//  MovieSelector
//
//  Created by Cagdas Timurlenk on 21.09.2018.
//  Copyright © 2018 CodeAndDreams. All rights reserved.
//

import Foundation
protocol MovieBusinessLogic {
    func getMovieDetail(_ request: MovieDetail.Request)
}

//https://api.themoviedb.org/3/movie/{movie_id}/videos?api_key=<<api_key>>&language=en-US
class MovieInteractor: MovieBusinessLogic{
    var presenter: MoviePresentationLogic?
    func getMovieDetail(_ request: MovieDetail.Request) {
                MovieApi.getMovieDetail(request: request,
                                             success:
                    {
                        [weak weakSelf = self] (response) in
                        weakSelf?.presenter?.presentMovieDetail(MovieDetail.Response(data: response))
                })
        }
    }

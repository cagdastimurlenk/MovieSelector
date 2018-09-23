//
//  MovieListInteractor.swift
//  MovieSelector
//
//  Created by Cagdas Timurlenk on 21.09.2018.
//  Copyright © 2018 CodeAndDreams. All rights reserved.
//

import Foundation
protocol MovieListBusinessLogic {
    func getPopularMovieList(_ request: MovieList.Request)
    func saveMovieToDatabase(movieViewModel : MovieList.ViewModel.MovieViewModel , withLike : Bool)
}

class MovieListInteractor: MovieListBusinessLogic{
    var presenter: MovieListPresentationLogic?
    
    func getPopularMovieList(_ request: MovieList.Request) {
        MovieApi.getPopularMovieList(request: request,
                                          success:
            {
                [weak weakSelf = self] (response) in
                weakSelf?.presenter?.presentMovieList(MovieList.Response(data: response))
        })
    }
    func saveMovieToDatabase(movieViewModel: MovieList.ViewModel.MovieViewModel, withLike: Bool) {
        let dto = MovieDTO()
        dto.isLiked = String(withLike)
        dto.movieId = movieViewModel.movieId
        dto.voteAverage = movieViewModel.voteAverage
        dto.releaseDate = movieViewModel.releaseDate
        dto.posterPath = movieViewModel.posterPath
        dto.overview = movieViewModel.overview
        dto.title = movieViewModel.title
        let movieStore = RealmStore<RealmMovie>()
        movieStore.insert(item: dto)
        
        //let a = movieStore.getAll()
    }
}

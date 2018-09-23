//
//  MovieModels.swift
//  MovieSelector
//
//  Created by Cagdas Timurlenk on 21.09.2018.
//  Copyright © 2018 CodeAndDreams. All rights reserved.
//

import Foundation

enum MovieList{
//    api_key=97cadb94c4c37e4999e6ef7d85d9d941&language=en-US&page=1

    struct Request: DictionaryRepresentation {
        var page : Int
        
        var dictionaryRepresentation: [String : Any]{
            
            return [
                "api_key" : Constants.MovieApiCred.apiKey,
                "language" : Constants.MovieApiCred.language,
                "page" : page
            ]
        }
    }
    struct Response {
        let data: MovieListResponseDTO
        
        func getViewModel() -> ViewModel{
            var movieResponseModel = ViewModel.MovieResponseViewModel()
            movieResponseModel.page = data.page
            movieResponseModel.totalPages = data.totalPages
            var moviesResponse = [ViewModel.MovieViewModel]()
            
            data.results?.forEach{ (dto) in
                
                let voteCount = dto.voteCount ?? 0
                let movieId = dto.movieId ?? 0
                let voteAverage = dto.voteAverage ?? 0
                let posterPath = dto.posterPath ?? ""
                let releaseDate = dto.releaseDate?.split(separator: "-").first ?? ""
                let overView = dto.overview ?? ""
                let title = dto.title ?? ""
                let movieModel = ViewModel.MovieViewModel(voteCount: voteCount, movieId: movieId, voteAverage: voteAverage, posterPath: posterPath, overview: overView, releaseDate: String(releaseDate), title: title)
                moviesResponse.append(movieModel)
            }
            movieResponseModel.result = moviesResponse
            return ViewModel(movieView: movieResponseModel)
        }
    }
    struct ViewModel {
        let movieView: MovieResponseViewModel
        
        struct MovieResponseViewModel {
            var page: Int?
            var totalPages: Int?
            var result: [MovieViewModel]?
        }
        
        struct MovieViewModel {
            let voteCount : Int
            let movieId : Int
            let voteAverage : Double
            let posterPath : String
            let overview : String
            let releaseDate : String
            let title : String
        }
    }
    
}

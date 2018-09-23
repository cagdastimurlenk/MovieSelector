//
//  MovieDetailModels.swift
//  MovieSelector
//
//  Created by Cagdas Timurlenk on 22.09.2018.
//  Copyright © 2018 CodeAndDreams. All rights reserved.
//

import Foundation
enum MovieDetail{
    //    api_key=97cadb94c4c37e4999e6ef7d85d9d941&language=en-US&page=1
    
    struct Request: DictionaryRepresentation {
        var movieId : Int?
        var dictionaryRepresentation: [String : Any]{
            
            return [
                "api_key" : Constants.MovieApiCred.apiKey,
                "language" : Constants.MovieApiCred.language
            ]
        }
    }
    struct Response {
        let data: MovieDetailResponseDTO
        
        func getViewModel() -> ViewModel{
            var movieResponseModel = ViewModel.MovieResponseDetailViewModel()
            movieResponseModel.movieId = data.movieId
            var movieDetailResponse = [ViewModel.MovieDetailViewModel]()
            
            data.results?.forEach{ (dto) in
                
                let movieDetailId = dto.movieDetailId ?? ""
                let iso = dto.iso ?? ""
                let key = dto.key ?? ""
                let name = dto.name ?? ""
                let site = dto.site ?? ""
                let type = dto.type ?? ""
                let movieDetailModel = ViewModel.MovieDetailViewModel(movieDetailId: movieDetailId, iso: iso, key: key, name: name, site: site, type: type)
                movieDetailResponse.append(movieDetailModel)
            }
            movieResponseModel.result = movieDetailResponse
            return ViewModel(movieView: movieResponseModel)
        }
    }
    struct ViewModel {
        let movieView: MovieResponseDetailViewModel
        
        struct MovieResponseDetailViewModel {
            var movieId: Int?
            var result: [MovieDetailViewModel]?
        }
        
        struct MovieDetailViewModel {
            let movieDetailId : String
            let iso : String
            let key : String
            let name : String
            let site : String
            let type : String
        }
    }
    
}

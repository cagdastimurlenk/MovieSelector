//
//  MovieApiTarget.swift
//  MovieSelector
//
//  Created by Cagdas Timurlenk on 21.09.2018.
//  Copyright © 2018 CodeAndDreams. All rights reserved.
//

import Foundation
import Moya


enum MovieApiTarget{
    case getPopularMovieList(request: MovieList.Request)
    case getMovieDetail(request : MovieDetail.Request)
}


extension MovieApiTarget: ApiTarget{
    var path: String {
        switch self {
        case .getPopularMovieList:
            return "popular"
        case .getMovieDetail(let request):
            return "\(request.movieId ?? 0)/videos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPopularMovieList:
            return .get
        case .getMovieDetail:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getPopularMovieList(let request):
            return request.dictionaryRepresentation
        case .getMovieDetail(let request) :
            return request.dictionaryRepresentation
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .request
    }
    
    var parameterEncoding: ParameterEncoding{
        return URLEncoding.default
    }
}

//
//  Constants.swift
//  Appsurt
//
//  Created by volkan biçer on 30/12/2016.
//  Copyright © 2016 Tronasoft. All rights reserved.
//

import Foundation


struct  Constants {
    
    struct MovieApiCred {
        static let apiKey = "97cadb94c4c37e4999e6ef7d85d9d941"
        static let language = "en-US"
        static let imageBase = "http://image.tmdb.org/t/p/w780/"
    }
    
    struct ServiceError {
        static let InternalServerError = "Something went wrong!"
        static let ParsingError = "Service repsonse parsing error occured!"
    }
    
    
    struct Notification {
        static let networkError = "NetworkError"
    }
    
    struct Indentifier {
        static let movieCollectionViewCell = "MovieCollectionViewCell"
    }
}

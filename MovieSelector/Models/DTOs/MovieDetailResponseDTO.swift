//
//  MovieDetailResponseDTO.swift
//  MovieSelector
//
//  Created by Cagdas Timurlenk on 22.09.2018.
//  Copyright © 2018 CodeAndDreams. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieDetailResponseDTO: Mappable {
    
    public var movieId :  Int?
    public var results : [MovieDetailDTO]?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        movieId <- map["id"]
        results <- map["results"]
    }
}

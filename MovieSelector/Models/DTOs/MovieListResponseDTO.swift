//
//  MovieListResponseDTO.swift
//  MovieSelector
//
//  Created by Cagdas Timurlenk on 21.09.2018.
//  Copyright © 2018 CodeAndDreams. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieListResponseDTO: Mappable {
    
    public var page :  Int?
    public var totalResults : Int?
    public var totalPages : Int?
    public var results : [MovieDTO]?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        page <- map["page"]
        totalResults <- map["total_results"]
        totalPages <- map["total_pages"]
        results <- map["results"]
    }
}


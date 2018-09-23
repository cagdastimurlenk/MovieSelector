//
//  MovieDTO.swift
//  MovieSelector
//
//  Created by Cagdas Timurlenk on 21.09.2018.
//  Copyright © 2018 CodeAndDreams. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieDTO :Mappable
{
    
    public var voteCount :  Int?
    public var movieId : Int?
    public var hasVideo : Bool?
    public var voteAverage : Double?
    public var title : String?
    public var popularity : String?
    public var posterPath : String?
    public var originalLanguage : String?
    public var isAdult : Bool?
    public var overview : String?
    public var releaseDate : String?
    public var backdropPath : String?
    public var isLiked : String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        voteCount <- map["vote_count"]
        movieId <- map["id"]
        hasVideo <- map["video"]
        voteAverage <- map["vote_average"]
        title <- map["title"]
        popularity <- map["popularity"]
        posterPath <- map["poster_path"]
        originalLanguage <- map["original_language"]
        isAdult <- map["adult"]
        overview <- map["overview"]
        releaseDate <- map["release_date"]
        backdropPath <- map["backdrop_path"]
    }
}

//
//  RealmMovie.swift
//  MovieSelector
//
//  Created by Cagdas Timurlenk on 23.09.2018.
//  Copyright © 2018 CodeAndDreams. All rights reserved.
//

import Foundation
import RealmSwift

class RealmMovie: Object {
    
    dynamic var id: String?
    dynamic var voteAverage : String?
    dynamic var releaseDate : String?
    dynamic var posterPath : String?
    dynamic var overview : String?
    dynamic var liked : String?
    dynamic var title : String?
    
    override class func primaryKey() -> String {
        return "id"
    }
}

extension RealmMovie:RealmEntity{
    var entity: MovieDTO {
        let dto = MovieDTO()
        dto.movieId = Int(id!)
        dto.voteAverage = Double(voteAverage!)
        dto.releaseDate = releaseDate
        dto.posterPath = posterPath
        dto.overview = overview
        dto.isLiked = liked
        dto.title = title
        return dto
    }
    
    func createFrom(_ entity: MovieDTO) {
        id = String(entity.movieId!)
        voteAverage = String(entity.voteAverage!)
        releaseDate = entity.releaseDate
        posterPath = entity.posterPath
        overview = entity.overview
        title = entity.title
        liked = entity.isLiked
    }
}

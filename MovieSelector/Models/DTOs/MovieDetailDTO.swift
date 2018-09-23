//
//  MovieDetailDTO.swift
//  MovieSelector
//
//  Created by Cagdas Timurlenk on 22.09.2018.
//  Copyright © 2018 CodeAndDreams. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieDetailDTO :Mappable
{
    
    public var movieDetailId :  String?
    public var iso : String?
    public var key : String?
    public var name : String?
    public var site : String?
    public var size : Int?
    public var type : String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        movieDetailId <- map["id"]
        iso <- map["iso_639_1"]
        key <- map["key"]
        name <- map["name"]
        site <- map["site"]
        type <- map["type"]
    }
}

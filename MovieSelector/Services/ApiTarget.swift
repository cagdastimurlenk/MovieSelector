//
//  ApiTarget.swift
//  MovieSelector
//
//  Created by Cagdas Timurlenk on 21.09.2018.
//  Copyright © 2018 CodeAndDreams. All rights reserved.
//

import Foundation
import Moya

protocol ApiTarget:TargetType {
    
}

extension ApiTarget{
    
    var headers: [String : String]? {
        return [:]
    }
    
    
    var validate: Bool{
        return false
    }
    
    var baseURL: URL { return URL(string: "https://api.themoviedb.org/3/movie/")! }
    
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
        
    }
}

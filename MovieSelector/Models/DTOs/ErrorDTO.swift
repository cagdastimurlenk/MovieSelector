//
//  ErrorDTO.swift
//  MovieSelector
//
//  Created by Cagdas Timurlenk on 21.09.2018.
//  Copyright © 2018 CodeAndDreams. All rights reserved.
//

import Foundation
import ObjectMapper

class ErrorDTO: Mappable{
    var message: String  = "Something went wrong"
    //var parameterizedError: ParameterizedErrorDTO?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        message <- map["message"]
      //  parameterizedError <- map["params"]
    }
    
    func getErrorMessage() -> String{
//        return parameterizedError?.message ?? message
        return message
    }
}


//
//class ParameterizedErrorDTO: Mappable{
//    var message = "Something went wrong"
//
//    convenience required init?(map: Map) {
//        self.init()
//    }
//
//    func mapping(map: Map) {
//        message <- map["param0"]
//    }
//}

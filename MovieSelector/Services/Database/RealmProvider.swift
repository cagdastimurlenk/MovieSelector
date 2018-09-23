//
//  RealmProvider.swift
//  
//
//  Created by Cagdas Timurlenk on 15/09/2017.
//  Copyright © 2017 Tronasoft. All rights reserved.
//

import Foundation
import RealmSwift

class RealmProvider {
    class func realm(inMemoryIdentifier: String? = nil) throws -> Realm{        
        if let identifier = inMemoryIdentifier {
            return try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: identifier))
        } else {
            do{
             return try Realm(configuration:config)
            }
            catch{
                return try! Realm()
            }
        }
    }
    
    
    
    private static var config = Realm.Configuration(
        
        encryptionKey: key,
        // Set the new schema version. This must be greater than the previously used
        // version (if you've never set a schema version before, the version is 0).
        schemaVersion: 2,
        
        // Set the block which will be called automatically when opening a Realm with
        // a schema version lower than the one set above
        migrationBlock: { migration, oldSchemaVersion in
            // We haven’t migrated anything yet, so oldSchemaVersion == 0
            if (oldSchemaVersion < 1) {
      
                // Nothing to do!
                // Realm will automatically detect new properties and removed properties
                // And will update the schema on disk automatically
            }
    })
    
    
    static var key: Data = "Lorem Ipsum is simply dummy text of the printing and typesetting".data(using: .utf8)!
    
}



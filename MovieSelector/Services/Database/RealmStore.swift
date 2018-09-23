//
//  RealmStore.swift
//  
//
//  Created by Cagdas Timurlenk on 13/09/2017.
//  Copyright © 2017 Tronasoft. All rights reserved.
//

import RealmSwift
import ObjectMapper

import Foundation
class RealmStore<T> where T: Object, T: RealmEntity{
    
    fileprivate let realm:Realm!
    
    init(_ inMemoryIdentifier: String? = nil) {
        realm = try! RealmProvider.realm(inMemoryIdentifier: inMemoryIdentifier)
//        print(realm.configuration)
    }
    
    
    func getAll()-> [T.EntityType]{
        return realm.objects(T.self).flatMap {$0.entity}
    }
    
    
    func insert(item: T.EntityType, update: Bool = false){
        try! realm.write {
            var d = T()
            d.createFrom(item)
            realm.add(d, update: update)
        }
    }
    
    
    func bulkInsert(items: [T.EntityType]){
        for item in items{
            insert(item: item)
        }
    }
    
    
    func clean(){
        try! realm.write {
            realm.delete(realm.objects(T.self))
        }
    }
    
    
    func cleanDatabase(){
        try! realm.write {
            realm.deleteAll()
        }
    }
}


extension RealmStore where T:RealmQuery {
    func filter(matching query: T.Query) -> [T.EntityType]{
        var results = realm.objects(T.self)
        
        if let predicate = query.predicate{
            results = results.filter(predicate)
        }
        
        results = results.sorted(by: query.sortDescriptors)
        return results.flatMap{$0.entity}
    }
    
    
    func delete(by query: T.Query){
        var items = realm.objects(T.self)
        
        if let predicate = query.predicate{
            items = items.filter(predicate)
        }
        
        try! realm.write {
            realm.delete(items)
        }
    }    
}


protocol RealmEntity {
    associatedtype EntityType
    
    mutating func createFrom(_ entity: EntityType)
    var entity: EntityType { get }
}





protocol QueryType{
    var predicate:NSPredicate? {get}
    var sortDescriptors: [SortDescriptor] {get}
}


protocol RealmQuery {
    associatedtype Query: QueryType
}

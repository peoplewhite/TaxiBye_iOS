//
//  RealmMachine.swift
//  
//
//  Created by sean on 2017/2/3.
//
//

import Foundation
import Realm
import RealmSwift


class RealmMachine {


    func save() {
        
    }

    static func saveTaxi(_ taxi: Taxi) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(taxi, update: true)
        }
    }

//    static func getTaxis() -> [Taxi] {
//        let realm = try! Realm()
//        return realm.objects(Taxi.self)
//    }

    func read() {
        
    }
    
}

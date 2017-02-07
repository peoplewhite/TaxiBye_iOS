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

    func saveTaxi(_ taxi: Taxi) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(taxi, update: true)
        }
    }
    
    func read() {
        
    }
    
}

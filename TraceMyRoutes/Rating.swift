//
//  Rating.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/2/3.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import Foundation
import RealmSwift

class Rating: Object {
    
    dynamic var id: Int = 0
    dynamic var score: Double = 0.0
    dynamic var message = ""
    dynamic var trip_id: Int = 0
    dynamic var created_at = NSDate()
    dynamic var updated_at = NSDate()
    dynamic var trip_feeling_id: Int = 0
    
}

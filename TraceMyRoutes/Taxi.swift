//
//  Taxi.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/2/3.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import Foundation
import RealmSwift

class Taxi: Object {
    
    dynamic var  plate_number :String = ""
    dynamic var  driver       :String = ""
    dynamic var  avg_rating   :Double = 0.0
    dynamic var  created_at   = NSDate()
    dynamic var  updated_at   = NSDate()
    
}

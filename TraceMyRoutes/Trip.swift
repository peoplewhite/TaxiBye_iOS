//
//  Trip.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/2/3.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import Foundation
import RealmSwift

class Trip: Object {

    dynamic var id:Int = 0
    dynamic var route = ""
    dynamic var started_at = NSDate()
    dynamic var ended_at = NSDate()
    dynamic var created_at = NSDate()
    dynamic var updated_at = NSDate() 
    dynamic var taxi_plate_number = ""
    
}

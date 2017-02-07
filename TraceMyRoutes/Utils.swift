//
//  Utils.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/2/2.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import Foundation
import UIKit

class Utils {

    class var sharedInstance : Utils {
        struct Static {
            static let instance : Utils = Utils()
        }
        return Static.instance
    }



    var tempComment = ""
    

    func getCurrentTimeByUnixTimeFormat() -> String {
       return Date().timeIntervalSince1970.description.components(separatedBy: ".").first!
    }
    
}

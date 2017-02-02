//
//  TraceRouteMachine.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/1/24.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import Foundation

class TraceRouteMachine {

    class var shared : TraceRouteMachine {
        struct Static {
            static let instance : TraceRouteMachine = TraceRouteMachine()
        }
        return Static.instance
    }

    var carPlateNumber = ""
    var ratingNumber: Int = 0 //default

    var comment = ""
    var isLocationTraceDone = false

    func initMachine() {
        carPlateNumber = ""
        ratingNumber = 0 //default
        comment = ""
    }
    func startTraceLocation() {
        isLocationTraceDone = false
    }

}

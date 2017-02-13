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


    var isLocationTraceDone = false
    
    var traceStartTime = ""
    var traceEndTime = ""

    
    var carPlateNumber = ""
    var ratingNumber: Int = 0 //default
    var comment = ""
    var traceFeelingID: Int = 0 //default

    func initMachine() {
        carPlateNumber = ""
        ratingNumber = 0 //default
        comment = ""
        traceFeelingID = 0
    }
    func startTraceLocation() {
        isLocationTraceDone = false
        traceStartTime = Utils.sharedInstance.getCurrentTimeByUnixTimeFormat()
    }
    func endTraceLocation() {
        isLocationTraceDone = true
        traceEndTime = Utils.sharedInstance.getCurrentTimeByUnixTimeFormat()
    }


}

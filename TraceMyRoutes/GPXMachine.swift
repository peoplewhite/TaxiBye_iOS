//
//  GPXMachine.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/2/4.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import Foundation
import CoreLocation

class GPXMachine {

    class var shared : GPXMachine {
        struct Static {
            static let instance : GPXMachine = GPXMachine()
        }
        return Static.instance
    }

    var gpx = GPXRoot()
    var track = GPXTrack()


    func initMachine(withTitle title: String) {
        gpx = GPXRoot(creator: title)
        track = gpx.newTrack()
        track.name = title
    }

    func save(_ currentLocation: CLLocation) {
        track.newTrackpoint(
            withLatitude: CGFloat(currentLocation.coordinate.latitude),
            longitude: CGFloat(currentLocation.coordinate.longitude)
        )
    }

    var gpxString: String {
        return gpx.gpx()
    }

    
}

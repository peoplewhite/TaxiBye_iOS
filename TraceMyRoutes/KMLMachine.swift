//
//  KMLMachine.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/1/24.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import Foundation
import iOS_KML_Framework
import CoreLocation


class KMLMachine {

    class var shared : KMLMachine {
        struct Static {
            static let instance : KMLMachine = KMLMachine()
        }
        return Static.instance
    }

    //start here

    var root = KMLRoot()
    var doc = KMLDocument()

    func initMachine() {

        root = KMLRoot()
        doc = KMLDocument()

        root.feature = doc

    }

    func save(_ currentLocation: CLLocation) {

        let placemark = KMLPlacemark()
        placemark.name = ""
        placemark.descriptionValue = ""

        let point = KMLPoint()
        placemark.geometry = point

        let coordinate = KMLCoordinate()
        coordinate.latitude = CGFloat(currentLocation.coordinate.latitude)
        coordinate.longitude = CGFloat(currentLocation.coordinate.longitude)
        point.coordinate = coordinate

        doc.addFeature(placemark)

//        print("save to KML") //kimuranow
//        print("doc = \(doc.description)") //kimuranow
    }




}

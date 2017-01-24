//
//  TracingViewController.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/1/24.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import UIKit
import CoreLocation
import iOS_KML_Framework

class TracingViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkCoreLocationPermission()




        let root = KMLRoot()
        let doc = KMLDocument()
        root.feature = doc

        let placemark = KMLPlacemark()
        placemark.name = ""
        placemark.descriptionValue = ""
        doc.addFeature(placemark)

        let point = KMLPoint()
        placemark.geometry = point

        let coordinate = KMLCoordinate()
        coordinate.latitude = 0.0
        coordinate.longitude = 0.0
        point.coordinate = coordinate

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }

    func checkCoreLocationPermission() {
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break
        default:
            locationManager.requestWhenInUseAuthorization()
            break;
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print(" = \(locations)") //kimuranow
//        print(" = \(locations.)") //kimuranow
        let currentLocation: CLLocation = locations[0]
        print(" = \(currentLocation.coordinate.latitude), \(currentLocation.coordinate.longitude)") //kimuranow
        
        
    }

}

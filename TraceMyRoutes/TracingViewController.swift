//
//  TracingViewController.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/1/24.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import UIKit
import CoreLocation


class TracingViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkCoreLocationPermission()

        // TODO: refactor this
        
        KMLMachine.shared.initMachine()

        TraceRouteMachine.shared.startTraceLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func endButtonPressed(_ sender: UIButton) {
        TraceRouteMachine.shared.isLocationTraceDone = true
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

        guard !TraceRouteMachine.shared.isLocationTraceDone else {
            return
        }

        let currentLocation: CLLocation = locations[0]
        print(" = \(currentLocation.coordinate.latitude), \(currentLocation.coordinate.longitude)") //kimuranow
        KMLMachine.shared.save(currentLocation)
    }

}

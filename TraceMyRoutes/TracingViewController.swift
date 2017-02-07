//
//  TracingViewController.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/1/24.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps


class TracingViewController: UIViewController, CLLocationManagerDelegate, ConfirmEmergencyPhoneCallSceneDelegate {

    @IBOutlet weak var carPlateNumberLabel: UILabel!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var endButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var emergencyButtonheightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mapContainer: GMSMapView!

    var carPlateNumber = ""
    let locationManager = CLLocationManager()


    var locations = [CLLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        path = GMSMutablePath()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkCoreLocationPermission()

        // TODO: refactor this

        if AppConfig.isUsingGPX {
            GPXMachine.shared.initMachine(withTitle: carPlateNumber)
        } else {
            KMLMachine.shared.initMachine()
        }

        TraceRouteMachine.shared.startTraceLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func endButtonPressed(_ sender: UIButton) {
        TraceRouteMachine.shared.isLocationTraceDone = true
        TraceRouteMachine.shared.carPlateNumber = self.carPlateNumber
    }

    override func viewWillAppear(_ animated: Bool) {

        carPlateNumberLabel.text = carPlateNumber.description
        initUI()

        drawLine(with: CLLocation())
    }

    func initUI() {
        settingEndButtonUI()
        settingEmergencyButtonUI()
    }

    func settingEmergencyButtonUI() {

        emergencyButtonheightConstraint.constant = AppConfig.searchbuttonInFirstSceneHeight
        view.layoutIfNeeded()
        
    }
    
    func settingEndButtonUI() {

        endButtonWidthConstraint.constant = AppConfig.buttonHeight
        view.layoutIfNeeded()
        
        endButton.clipsToBounds = true
        endButton.layer.cornerRadius = endButton.frame.size.height / 2.0

        
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

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        guard status == .authorizedWhenInUse else {
            return
        }

        locationManager.startUpdatingLocation()

        mapContainer.isMyLocationEnabled = true
//        mapContainer.settings.myLocationButton = true
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard !TraceRouteMachine.shared.isLocationTraceDone else {
            return
        }

        let currentLocation: CLLocation = locations[0]
        print("currentLocation = \(currentLocation.coordinate.latitude), \(currentLocation.coordinate.longitude)") //kimuranow

        if AppConfig.isUsingGPX {
            GPXMachine.shared.save(currentLocation)
        } else {
            KMLMachine.shared.save(currentLocation)
        }


        mapContainer.camera = GMSCameraPosition(target: currentLocation.coordinate, zoom: 18, bearing: 0, viewingAngle: 0)
        drawLine(with: currentLocation)

    }
    @IBAction func emergencyButtonPressed(_ sender: UIButton) {

        showAlertViewBeforeCallEmergencyPhoneCall()
    }
    func callEmergencyPhoneCall() {
        
        let phone = URL(string: "tel://\(AppConfig.emergencyPhoneNumber)")
        UIApplication.shared.open(phone!, options: [:], completionHandler: nil)
    }
    func showAlertViewBeforeCallEmergencyPhoneCall() {

        let confirmEmergencyPhoneCallScene: ConfirmEmergencyPhoneCallScene = Bundle.main.loadNibNamed("ConfirmEmergencyPhoneCallScene", owner: self, options: nil)![0] as! ConfirmEmergencyPhoneCallScene
        confirmEmergencyPhoneCallScene.frame = UIScreen.main.bounds
        confirmEmergencyPhoneCallScene.delegate = self
        UIApplication.shared.keyWindow?.addSubview(confirmEmergencyPhoneCallScene)
    }
    func drawLine(with point: CLLocation) {

        locations.append(point)
        print("kimura check latitude = \(point.coordinate.latitude)") //kimuranow

        if locations.first?.coordinate.latitude == 0 {
            locations.remove(at: 0)
        }

        let path = GMSMutablePath()

        locations.forEach { l in
            path.add(l.coordinate)
        }

        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = UIColor.red
        polyline.strokeWidth = 10.0
        polyline.geodesic = true
        polyline.map = mapContainer

    }
}

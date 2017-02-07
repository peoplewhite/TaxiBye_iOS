//
//  FirstViewController.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/1/24.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import UIKit
import SVProgressHUD
import RealmSwift
import Realm
import JSONAPI

class FirstViewController: UIViewController, WarningSceneDelegate {

    @IBOutlet weak var trackButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var plateNumberTextfield: UITextField!

    @IBOutlet weak var trackButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchButtonHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)

        SVProgressHUD.setMinimumDismissTimeInterval(2)
    }

    override func viewWillAppear(_ animated: Bool) {
        initUI()

        let realm = try! Realm()
        print("feeling = \(realm.objects(Feeling.self))") //kimuranow
        print("taxi = \(realm.objects(Taxi.self))") //kimuranow
        print("rating = \(realm.objects(Rating.self))") //kimuranow
        print("trip = \(realm.objects(Trip.self))") //kimuranow

        let root = GPXRoot()



        /*
       let json = [

        "data": [
            "id": "24",
            "type": "trips",
            "attributes": [
                "startedAt": 1486453039,
                "endedAt": 1486453039,
                "route": "abcdefg",
                "updatedAt": 1486453039
            ],
            "relationships": [
                "rating": [
                    "data": [
                        "id": "24",
                        "type": "ratings"
                    ]
                ],
                "taxi": [
                    "data": [
                        "id": "1234-XD",
                        "type": "taxis"
                    ]]]
        ],
        "included": [
            [
                "id": "24",
                "type": "ratings",
                "attributes": [
                    "score": "5.0",
                    "message": "還可以",
                    "tripFeeling": "fine",
                    "updatedAt": 1486453039
                ]
            ],
            [
                "id": "1234-XD",
                "type": "taxis",
                "attributes": [
                    "plateNumber": "1234-XD",
                    "driver": "",
                    "avgRating": "4.6",
                    "updatedAt": 1486453018
                ]]
        ]
        ] as [String : Any]

        let jsonAPI = JSONAPI(dictionary: json)
        print("jsonAPI = \(jsonAPI?.resource)") //kimuranow

         */


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initUI() {
        settingUIForTrackButton()
        settingUIForSearchButtonHeight()
    }
    func settingUIForTrackButton() {
        trackButtonHeightConstraint.constant = AppConfig.buttonHeight
        trackButton.layer.cornerRadius = AppConfig.buttonHeight / 2.0
    }

    func goTraceScene() {
        performSegue(withIdentifier: "goTraceScene", sender: nil)

    }
    
    func settingUIForSearchButtonHeight() {
        searchButtonHeightConstraint.constant = AppConfig.searchbuttonInFirstSceneHeight
    }
    @IBAction func trackButtonPressed(_ sender: UIButton) {
        
        
        let trimmedString = plateNumberTextfield.text!.trimmingCharacters(in: .whitespaces)

        guard trimmedString.characters.count > 0 else {
            showAlertViewWith(msg: "請輸入車牌號碼")
            return
        }

        showWarningScene()
//        goTraceScene()

    }
    func showAlertViewWith(msg: String) {

        // swift 3.0
        let alert:UIAlertController = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            alert.dismiss(animated: false, completion: nil)
        }))
        present(alert, animated: true, completion: nil)

    }


    func showWarningScene() {

        let chooseTagBrandScene: WarningScene = Bundle.main.loadNibNamed("WarningScene", owner: self, options: nil)![0] as! WarningScene
        chooseTagBrandScene.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        UIApplication.shared.keyWindow?.addSubview(chooseTagBrandScene)
        chooseTagBrandScene.delegate = self
        

        let kAnimationDuration: Double = 0.3

        UIView.animate(withDuration: kAnimationDuration, animations: {() -> Void in
            chooseTagBrandScene.frame = UIScreen.main.bounds
        }, completion: {(finished: Bool) -> Void in
            
        })

    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goTraceScene" {
            let vc: TracingViewController = segue.destination as! TracingViewController
            vc.carPlateNumber = plateNumberTextfield.text!
        }
    }
}

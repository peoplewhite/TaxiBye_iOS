//
//  FirstViewController.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/1/24.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import UIKit
import SVProgressHUD
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


        API.authenticate(completion: {

        }) { (errorMessage) in

        }


        API.fetchFeelingList(completion: { 
            //

            let feelings: [Feeling] = Feeling.mr_findAll() as! [Feeling]
            print("feelings = \(feelings)") //kimuranow
            feelings.forEach { feeling in
                print("feeling = \(feeling.id)\(feeling.title)") //kimuranow
            }

        }) { (errorMessage) in
            //
        }
    }

    var currentTrip: Trip!

    override func viewWillAppear(_ animated: Bool) {
        initUI()
        
        let root = GPXRoot()


        let taxis: [Taxi] = Taxi.mr_findAll() as! [Taxi]
        print("taxis = \(taxis)") //kimuranow
        taxis.forEach { taxi in
            print("taxi = \(taxi.plate_number)\(taxi.driver)") //kimuranow
        }

        let feelings = Feeling.mr_findAll() as! [Feeling]
        feelings.forEach { feeling in
            print("feeling = \(feeling.id)\(feeling.title)") //kimuranow
        }

        plateNumberTextfield.text = ""
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

        // TODO: check valid plate number format
        // ref: https://zh.wikipedia.org/wiki/臺灣車輛牌照
        

        callAPIToQueryTaxiRating(withPlateNumber: trimmedString)
    }
    
    func callAPIToQueryTaxiRating(withPlateNumber plateNumber: String) {
        SVProgressHUD.show()
        API.queryTaxi(by: plateNumber, completion: { (taxi) in

            SVProgressHUD.dismiss()

            let isNeedToShowWarning = ((taxi.avg_rating?.doubleValue)! < AppConfig.lowerRatingForWarning)

            if isNeedToShowWarning {
                self.showWarningScene(withTaxi: taxi)
            } else {
                self.goTraceScene()
            }
            
        }) { (errorMessage) in
            
            SVProgressHUD.dismiss()
            self.showAlertViewWith(msg: errorMessage)
            
        }
    }
    
    func showAlertViewWith(msg: String) {

        let alert:UIAlertController = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            alert.dismiss(animated: false, completion: nil)
        }))
        present(alert, animated: true, completion: nil)

    }


    func showWarningScene(withTaxi taxi: Taxi) {

        let chooseTagBrandScene: WarningScene = Bundle.main.loadNibNamed("WarningScene", owner: self, options: nil)![0] as! WarningScene
        chooseTagBrandScene.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        UIApplication.shared.keyWindow?.addSubview(chooseTagBrandScene)
        chooseTagBrandScene.delegate = self

        chooseTagBrandScene.setupTaxiData(with: taxi)

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

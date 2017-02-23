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

    @IBOutlet weak var firstCarPlateNumberTextfield: UITextField!
    @IBOutlet weak var secondCarPlateNumberTextfield: UITextField!


//    @IBAction func enterTypePlateNumberSceneButtonPressed(_ sender: UIButton) {
//
//        let typeCarPlateNumberScene: TypeCarPlateNumberScene = Bundle.main.loadNibNamed("TypeCarPlateNumberScene", owner: self, options: nil)![0] as! TypeCarPlateNumberScene
//        typeCarPlateNumberScene.frame = UIScreen.main.bounds
//        typeCarPlateNumberScene.delegate = self
//        view.addSubview(typeCarPlateNumberScene)
//    }

    @IBAction func firstCarPlateNumberEditingChanged(_ sender: UITextField) {
        sender.text = sender.text?.uppercased()
    }
    @IBAction func secondCarPlateNumberEditingChanged(_ sender: UITextField) {
        sender.text = sender.text?.uppercased()
    }


    @IBAction func closeKeyboardButtonPressed(_ sender: UIButton) {
        view.endEditing(true)
    }
    

    func setupCarPlateNumber(_ carPlateNumber: String) {
        plateNumberTextfield.text = carPlateNumber
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)

        SVProgressHUD.setMinimumDismissTimeInterval(2)


        API.authenticate(completion: {

        }) { (errorMessage) in

        }


        API.fetchFeelingList(completion: { 

            let feelings: [Feeling] = Feeling.mr_findAll() as! [Feeling]
            print("feelings = \(feelings)") //kimuranow
            feelings.forEach { feeling in
                print("feeling = \(feeling.id): \(feeling.title)") //kimuranow
            }

        }) { (errorMessage) in
            
        }
        
        let taxis: [Taxi] = Taxi.mr_findAll() as! [Taxi]
        print("taxis = \(taxis)") //kimuranow
        taxis.forEach { taxi in
            print("taxi = \(taxi.plate_number!): \(taxi.driver!): \(taxi.avg_rating!): \(taxi.ratings?.description)") //kimuranow
        }

        let feelings = Feeling.mr_findAll() as! [Feeling]
        feelings.forEach { feeling in
            print("feeling = \(feeling.id)\(feeling.title)") //kimuranow
        }
        let ratings = Rating.mr_findAll() as! [Rating]
        ratings.forEach { rating in
            print("rating = \(rating.id)\(rating.message)\(rating.trip_feeling)") //kimuranow
        }
    }

    var currentTrip: Trip!

    override func viewWillAppear(_ animated: Bool) {
        initUI()
        
        let root = GPXRoot()



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

    func isCarPlateNumberValid(_ carPlateNumber: String) -> Bool {

        let trimmedString = carPlateNumber.trimmingCharacters(in: .whitespaces)

        guard trimmedString.characters.count > 0 else {
            showAlertViewWith(msg: "未輸入車牌號碼")
            return false
        }

        guard trimmedString.characters.count < 5 && trimmedString.characters.count > 1 else {
            showAlertViewWith(msg: "車牌號碼數目錯誤")
            return false
        }

        let tSet = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        let invSet = tSet.inverted

        if (carPlateNumber.rangeOfCharacter(from: invSet) == nil) {
            return true
        } else {
            showAlertViewWith(msg: "車牌號碼無效")
            return false
        }
    }
    
    var carPlateNumber: String {
        let firstPlateNumberBytrimmedString = firstCarPlateNumberTextfield.text!.trimmingCharacters(in: .whitespaces)
        let secondPlateNumberBytrimmedString = secondCarPlateNumberTextfield.text!.trimmingCharacters(in: .whitespaces)

        if firstPlateNumberBytrimmedString == "" && secondPlateNumberBytrimmedString == "" {

            return ""
        }

        return "\(firstPlateNumberBytrimmedString.uppercased())-\(secondPlateNumberBytrimmedString.uppercased())"
        
    }
    @IBAction func trackButtonPressed(_ sender: UIButton) {

//        let trimmedString = plateNumberTextfield.text!.trimmingCharacters(in: .whitespaces)
//
//        guard isCarPlateNumberValid(trimmedString) else { return }

        guard isCarPlateNumberValid(firstCarPlateNumberTextfield.text!) else {
            return
        }

        guard isCarPlateNumberValid(secondCarPlateNumberTextfield.text!) else {

            return
        }


        print("carPlateNumber = \(carPlateNumber)") //kimuranow

        callAPIToQueryTaxiRating(withPlateNumber: carPlateNumber)
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
            vc.carPlateNumber = self.carPlateNumber
        }
    }
}

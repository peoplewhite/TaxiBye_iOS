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
    @IBOutlet weak var firstCarPlateNumberTextfield: UITextField!
    @IBOutlet weak var secondCarPlateNumberTextfield: UITextField!
    @IBOutlet weak var trackButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchButtonHeightConstraint: NSLayoutConstraint!



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

        }) { (errorMessage) in
            
        }
    }

    var currentTrip: Trip!

    override func viewWillAppear(_ animated: Bool) {
        initUI()
        
        firstCarPlateNumberTextfield.text = ""
        secondCarPlateNumberTextfield.text = ""

        UIApplication.shared.statusBarView?.backgroundColor = nil

        setupTrackButton()
    }

    func setupTrackButton() {
        trackButton.setTitle(NSLocalizedString("homeScenetarckButtonTitle", comment: ""), for: .normal)
    }
    override var prefersStatusBarHidden: Bool {
        return true
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
extension FirstViewController {
    // MARK: =================> textfield

    @IBAction func firstCarPlateNumberEditingChanged(_ sender: UITextField) {
        sender.text = sender.text?.uppercased()
    }
    @IBAction func secondCarPlateNumberEditingChanged(_ sender: UITextField) {
        sender.text = sender.text?.uppercased()
    }
}
extension FirstViewController {
    // MARK: =================> button

    @IBAction func closeKeyboardButtonPressed(_ sender: UIButton) {
        view.endEditing(true)
    }
    @IBAction func trackButtonPressed(_ sender: UIButton) {

        guard isCarPlateNumberValid(firstCarPlateNumberTextfield.text!) else {
            return
        }

        guard isCarPlateNumberValid(secondCarPlateNumberTextfield.text!) else {

            return
        }

        callAPIToQueryTaxiRating(withPlateNumber: carPlateNumber)
    }
}
extension FirstViewController {
    // MARK: =================> API

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
}

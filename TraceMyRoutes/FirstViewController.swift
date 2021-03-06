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
import ReachabilitySwift

class FirstViewController: UIViewController, WarningSceneDelegate {

    @IBOutlet weak var trackButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var firstCarPlateNumberTextfield: UITextField!
    @IBOutlet weak var secondCarPlateNumberTextfield: UITextField!
    @IBOutlet weak var trackButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchButtonHeightConstraint: NSLayoutConstraint!

    var reachability: Reachability!

    override func viewDidLoad() {

        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)

        SVProgressHUD.setMinimumDismissTimeInterval(2)

                
        do {
            //            reachability = try Reachability.reachabilityForInternetConnection()
            reachability = try Reachability.init()
        } catch {
            print("Unable to create Reachability")
        }

        // 檢測網絡連接狀態
        if reachability.isReachable {
            print("網絡連接：可用")
        } else {
            print("網絡連接：不可用")

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let noNetworkView = appDelegate.noNetworkView

            noNetworkView.frame = UIScreen.main.bounds
            noNetworkView.backgroundColor = UIColor.black.withAlphaComponent(0.6)

            let titleLabel = UILabel()
            titleLabel.frame = CGRect(x: 0.0, y: 200.0, width: UIScreen.main.bounds.width, height: 200.0)
            titleLabel.text = NSLocalizedString("noNetworkTip", comment: "")
            titleLabel.numberOfLines = 0
            titleLabel.backgroundColor = UIColor.clear
            titleLabel.textColor = UIColor.white
            titleLabel.textAlignment = .center
            titleLabel.font = titleLabel.font.withSize(25)
            noNetworkView.addSubview(titleLabel)
            UIApplication.shared.keyWindow?.addSubview(noNetworkView)

        }

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
            showAlertViewWith(msg: NSLocalizedString("homeSceneErrorMessageNoCarPlateNumber", comment: ""))
            return false
        }

        guard trimmedString.characters.count < 5 && trimmedString.characters.count > 1 else {
            showAlertViewWith(msg: NSLocalizedString("homeSceneErrorMessageCarPlateNumberFormatWrong", comment: ""))
            return false
        }

        let tSet = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        let invSet = tSet.inverted

        if (carPlateNumber.rangeOfCharacter(from: invSet) == nil) {
            return true
        } else {
            showAlertViewWith(msg: NSLocalizedString("homeSceneErrorMessageCarPlateNumberFormatWrong", comment: ""))
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
        }
    }
}

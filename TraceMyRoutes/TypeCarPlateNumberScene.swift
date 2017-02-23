//
//  TypeCarPlateNumberScene.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/2/23.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import UIKit

//1
protocol TypeCarPlateNumberSceneDelegate {
    func setupCarPlateNumber(_ carPlateNumber: String)
}

class TypeCarPlateNumberScene: UIView {

    @IBOutlet weak var firstPartTextfield: UITextField!
    @IBOutlet weak var secondPartTextfield: UITextField!

    let screenSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)

    var delegate:TypeCarPlateNumberSceneDelegate?


//    let tSet = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ")
//    let invSet = tSet.inverted
//
//    if (carPlateNumber.rangeOfCharacter(from: invSet) == nil) {
//    //Do the deal
//    } else {
//    showAlertViewWith(msg: "車牌號碼無效")
//    return false
//    }

    var carPlateNumber: String {


        let firstPlateNumberBytrimmedString = firstPartTextfield.text!.trimmingCharacters(in: .whitespaces)
        let secondPlateNumberBytrimmedString = secondPartTextfield.text!.trimmingCharacters(in: .whitespaces)


        if firstPlateNumberBytrimmedString == "" && secondPlateNumberBytrimmedString == "" {

            return ""
        }

        return "\(firstPlateNumberBytrimmedString.uppercased())-\(secondPlateNumberBytrimmedString.uppercased())"

    }
    @IBAction func exitButtonPressed(_ sender: UIButton) {
        print("carPlateNumber = \(carPlateNumber)") //kimuranow
        delegate?.setupCarPlateNumber(carPlateNumber)
        exitScene()
    }

    override func awakeFromNib() {

        firstPartTextfield.becomeFirstResponder()
        
        initValue()

        initUI()

    }

    func initValue() {

    }

    func initUI() {

    }


    func exitScene() {

        endEditing(true)

        let kDoubleAnimationDuration: Double = 0.3

        UIView.animate(withDuration: kDoubleAnimationDuration, animations: {() -> Void in

            self.alpha = 0.0

        }, completion: {(finished: Bool) -> Void in

            self.removeFromSuperview()
            
        })
        
    }
    
    
    // MARK: - set UI
    
    
    // MARK: - set value
}

//
//  ConfirmEmergencyPhoneCallScene.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/2/6.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import UIKit
protocol ConfirmEmergencyPhoneCallSceneDelegate {
    func callEmergencyPhoneCall()
}

class ConfirmEmergencyPhoneCallScene: UIView {

    let screenSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    var delegate:ConfirmEmergencyPhoneCallSceneDelegate?

    @IBOutlet weak var noButtonHeightConstraint: NSLayoutConstraint!


    // MARK: - setting zone

    @IBOutlet weak var phoneNumberLabel: UILabel!



    override func awakeFromNib() {

        initValue()

        initUI()

    }

    func initValue() {

    }

    func initUI() {
        setupEmergencyNumberLabel()
        setupNoButton()
    }
    func setupNoButton() {
        noButtonHeightConstraint.constant = AppConfig.noButtonInConfirmEmergencyPhoneCallSceneHeight
    }

    func setupEmergencyNumberLabel() {
        phoneNumberLabel.text = AppConfig.emergencyPhoneNumber.description
    }

    func exitScene() {

        let kDoubleAnimationDuration: Double = 0.3

        UIView.animate(withDuration: kDoubleAnimationDuration, animations: {() -> Void in

            self.frame = self.frame.offsetBy(dx: self.screenSize.width, dy: 0.0)


        }, completion: {(finished: Bool) -> Void in

            self.removeFromSuperview()
            
        })
        
    }
    
    
    // MARK: - set UI


    // MARK: - set value

    @IBAction func yesButtonPressed(_ sender: UIButton) {
        removeFromSuperview()
        delegate?.callEmergencyPhoneCall()
    }
    
    @IBAction func noButtonPressed(_ sender: UIButton) {
        removeFromSuperview()
    }

}

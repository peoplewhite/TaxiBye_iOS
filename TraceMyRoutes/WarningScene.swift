//
//  WarningScene.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/2/2.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import UIKit

class WarningScene: UIView {

    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!

    @IBOutlet weak var actionButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var actionButtonHeightConstraint: NSLayoutConstraint!



    

    let screenSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)


    // MARK: - setting zone



    override func awakeFromNib() {

        initValue()

        initUI()

    }

    func initValue() {

    }

    func initUI() {
        settingUIForActionButton()
    }

    func settingUIForActionButton() {

        actionButtonWidthConstraint.constant = AppConfig.buttonInWarningSceneSize.width
        actionButtonHeightConstraint.constant = AppConfig.buttonInWarningSceneSize.height
        layoutIfNeeded()
        
        settingButtonUI(yesButton)
        settingButtonUI(noButton)
    }

    func settingButtonUI(_ button: UIButton) {
        button.clipsToBounds = true
        button.layer.cornerRadius = button.frame.size.height / 2.0
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2.0
    }

    func exitScene() {

        let kAnimationDuration: Double = 0.3

        UIView.animate(withDuration: kAnimationDuration, animations: {() -> Void in
            self.frame = self.frame.offsetBy(dx: 0.0 , dy: self.screenSize.height)

        }, completion: {(finished: Bool) -> Void in
            self.removeFromSuperview()
            
        })
    }


    // MARK: - set UI
    

    // MARK: - set value



    func goTraceScene() {

    }
    func backToFirstScene() {
        exitScene()
    }

    @IBAction func noButtonPressed(_ sender: UIButton) {
        backToFirstScene()
    }

    @IBAction func yesButtonPressed(_ sender: UIButton) {
        goTraceScene()
    }

}

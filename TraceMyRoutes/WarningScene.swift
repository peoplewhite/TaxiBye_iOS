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

    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!

    @IBOutlet weak var starNumberLabel: UILabel!

    @IBOutlet weak var warningDescription: UILabel!


    let screenSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)


    // MARK: - setting zone



    override func awakeFromNib() {

        initValue()

        initUI()

        warningDescription.text = "此車輛的評價低於\n平均分數！"

    }

    func initValue() {

    }

    func initUI() {
        settingUIForActionButton()
        settingStar(2.5)
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


    func settingStar(_ starNumber: Float) {

        starNumberLabel.text = starNumber.description

        star1.image = AppConfig.emptyStarImage
        star2.image = AppConfig.emptyStarImage
        star3.image = AppConfig.emptyStarImage
        star4.image = AppConfig.emptyStarImage
        star5.image = AppConfig.emptyStarImage

        switch starNumber {
        case 0.0:
            break
        case 0.5:
            star1.image = AppConfig.halfStarImage
            break
        case 1.0:
            star1.image = AppConfig.fullStarImage
            break
        case 1.5:
            star1.image = AppConfig.fullStarImage
            star2.image = AppConfig.halfStarImage
            break
        case 2.0:
            star1.image = AppConfig.fullStarImage
            star2.image = AppConfig.fullStarImage
            break
        case 2.5:
            star1.image = AppConfig.fullStarImage
            star2.image = AppConfig.fullStarImage
            star3.image = AppConfig.halfStarImage
            break
        case 3.0:
            star1.image = AppConfig.fullStarImage
            star2.image = AppConfig.fullStarImage
            star3.image = AppConfig.fullStarImage
            break
        case 3.5:
            star1.image = AppConfig.fullStarImage
            star2.image = AppConfig.fullStarImage
            star3.image = AppConfig.fullStarImage
            star4.image = AppConfig.halfStarImage
            break
        case 4.0:
            star1.image = AppConfig.fullStarImage
            star2.image = AppConfig.fullStarImage
            star3.image = AppConfig.fullStarImage
            star4.image = AppConfig.fullStarImage
            break
        case 4.5:
            star1.image = AppConfig.fullStarImage
            star2.image = AppConfig.fullStarImage
            star3.image = AppConfig.fullStarImage
            star4.image = AppConfig.fullStarImage
            star5.image = AppConfig.halfStarImage
            break
        case 5.0:
            star1.image = AppConfig.fullStarImage
            star2.image = AppConfig.fullStarImage
            star3.image = AppConfig.fullStarImage
            star4.image = AppConfig.fullStarImage
            star5.image = AppConfig.fullStarImage
            break
        default:
            break
        }
        
    }
}

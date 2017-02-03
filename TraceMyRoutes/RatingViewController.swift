//
//  RatingViewController.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/1/24.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import UIKit
import SVProgressHUD

class RatingViewController: UIViewController {


    @IBOutlet weak var commentTextView: UITextView!

    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!

    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!

    @IBOutlet weak var optionButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentTextViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var submitButtonHeightConstraint: NSLayoutConstraint!


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)

        if TraceRouteMachine.shared.comment != "" {
            commentTextView.text = TraceRouteMachine.shared.comment
        }
        
        initUI()
    }

    func backToInitFirstScene() {
        _ = navigationController?.popToRootViewController(animated: true)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}

extension RatingViewController {
    // MARK: =================> UI

    func initUI() {
        settingUIForCommentTextView()
        settingUIForOptions()
        settingUIForSubmitButton()
    }
    func settingUIForCommentTextView() {
        commentTextView.clipsToBounds = true
        commentTextView.layer.cornerRadius = 6.0
        commentTextView.layer.borderColor = UIColor.black.cgColor
        commentTextView.layer.borderWidth = 2.0

        commentTextViewHeightConstraint.constant = AppConfig.commentTextViewSize
        view.layoutIfNeeded()

    }
    func settingUIForOptions() {
        optionButtonHeightConstraint.constant = AppConfig.searchbuttonInFirstSceneHeight
        view.layoutIfNeeded()
        
        settingButton(option1)
        settingButton(option2)
        settingButton(option3)
        settingButton(option4)

        option1.setTitle("還好", for: .normal)
        option2.setTitle("車速過快", for: .normal)
        option3.setTitle("態度不佳", for: .normal)
        option4.setTitle("爛透了", for: .normal)
    }
    func settingUIForSubmitButton() {
        submitButtonHeightConstraint.constant = AppConfig.buttonHeight
        view.layoutIfNeeded()
        submitButton.clipsToBounds = true
        submitButton.layer.cornerRadius = submitButton.frame.size.height / 2.0
    }
    func settingRatingNumber(_ ratingNumber: Int) {
        star1.setImage(AppConfig.blackEmptyStarImage, for: .normal)
        star2.setImage(AppConfig.blackEmptyStarImage, for: .normal)
        star3.setImage(AppConfig.blackEmptyStarImage, for: .normal)
        star4.setImage(AppConfig.blackEmptyStarImage, for: .normal)
        star5.setImage(AppConfig.blackEmptyStarImage, for: .normal)


        switch ratingNumber {
        case 1:
            star1.setImage(AppConfig.blackFullStarImage, for: .normal)
            break
        case 2:
            star1.setImage(AppConfig.blackFullStarImage, for: .normal)
            star2.setImage(AppConfig.blackFullStarImage, for: .normal)
            break
        case 3:
            star1.setImage(AppConfig.blackFullStarImage, for: .normal)
            star2.setImage(AppConfig.blackFullStarImage, for: .normal)
            star3.setImage(AppConfig.blackFullStarImage, for: .normal)
            break
        case 4:
            star1.setImage(AppConfig.blackFullStarImage, for: .normal)
            star2.setImage(AppConfig.blackFullStarImage, for: .normal)
            star3.setImage(AppConfig.blackFullStarImage, for: .normal)
            star4.setImage(AppConfig.blackFullStarImage, for: .normal)
            break
        case 5:
            star1.setImage(AppConfig.blackFullStarImage, for: .normal)
            star2.setImage(AppConfig.blackFullStarImage, for: .normal)
            star3.setImage(AppConfig.blackFullStarImage, for: .normal)
            star4.setImage(AppConfig.blackFullStarImage, for: .normal)
            star5.setImage(AppConfig.blackFullStarImage, for: .normal)
            break
        default:
            break
        }

        
    }
    
    func settingButton(_ b: UIButton) {

        b.clipsToBounds = true
        b.layer.cornerRadius = b.frame.size.height / 2.0
        b.layer.borderWidth = 2.0
        b.layer.borderColor = UIColor.black.cgColor
        b.setTitleColor(UIColor.black, for: .normal)
        b.backgroundColor = UIColor.clear
    }
}
extension RatingViewController {
    // MARK: =================> button
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        callAPIToPostTraceRoutes()
    }
}
extension RatingViewController {
    // MARK: =================> button (option)

    @IBAction func option1ButtonPressed(_ sender: UIButton) {
        if sender.backgroundColor == UIColor.clear {
            sender.backgroundColor = UIColor.black
            sender.setTitleColor(UIColor.white, for: .normal)
        } else {
            sender.backgroundColor = UIColor.clear
            sender.setTitleColor(UIColor.black, for: .normal)
        }
    }
    @IBAction func option2ButtonPressed(_ sender: UIButton) {
        if sender.backgroundColor == UIColor.clear {
            sender.backgroundColor = UIColor.black
            sender.setTitleColor(UIColor.white, for: .normal)
        } else {
            sender.backgroundColor = UIColor.clear
            sender.setTitleColor(UIColor.black, for: .normal)
        }
    }
    @IBAction func option3ButtonPressed(_ sender: UIButton) {
        if sender.backgroundColor == UIColor.clear {
            sender.backgroundColor = UIColor.black
            sender.setTitleColor(UIColor.white, for: .normal)
        } else {
            sender.backgroundColor = UIColor.clear
            sender.setTitleColor(UIColor.black, for: .normal)
        }

    }
    @IBAction func option4ButtonPressed(_ sender: UIButton) {
        if sender.backgroundColor == UIColor.clear {
            sender.backgroundColor = UIColor.black
            sender.setTitleColor(UIColor.white, for: .normal)
        } else {
            sender.backgroundColor = UIColor.clear
            sender.setTitleColor(UIColor.black, for: .normal)
        }

    }
}
extension RatingViewController {
    // MARK: =================> button (star)

    @IBAction func star1ButtonPressed(_ sender: UIButton) {
        settingRatingNumber(1)
    }
    @IBAction func star2ButtonPressed(_ sender: UIButton) {
        settingRatingNumber(2)
    }
    @IBAction func star3ButtonPressed(_ sender: UIButton) {
        settingRatingNumber(3)
    }
    @IBAction func star4ButtonPressed(_ sender: UIButton) {
        settingRatingNumber(4)
    }
    @IBAction func star5ButtonPressed(_ sender: UIButton) {
        settingRatingNumber(5)
    }
}

extension RatingViewController {
    // MARK: =================> API

    func callAPIToPostTraceRoutes() {

        API.postTraceRoutes(withKML: KMLMachine.shared.kmlFile,
                            andCarPlateNumber: TraceRouteMachine.shared.carPlateNumber,
                            andRatingNumber: TraceRouteMachine.shared.ratingNumber,
                            success: { (message) in backToInitFirstScene()
                                backToInitFirstScene()
                                SVProgressHUD.showSuccess(withStatus: "Submit 成功")
                                

        },
                            fail: { (errorMessage) in
                                print("fail") //kimuranow

        })
    }
}

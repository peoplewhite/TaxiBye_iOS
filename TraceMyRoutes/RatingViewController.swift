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



    @IBOutlet weak var commentLabel: UILabel!



    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!




    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {

        initUI()
    }

    func backToInitFirstScene() {
        _ = navigationController?.popToRootViewController(animated: true)
    }



    func settingRatingNumber(_ ratingNumber: Int) {

    }


    func initUI() {
        settingUIForCommentLabel()
        settingUIForOptions()

    }

    func settingUIForCommentLabel() {
        commentLabel.clipsToBounds = true
        commentLabel.layer.cornerRadius = 6.0
        commentLabel.layer.borderColor = UIColor.black.cgColor
        commentLabel.layer.borderWidth = 2.0

    }

    @IBAction func enterCommentSceneButtonPressed(_ sender: UIButton) {
        goCommentScene()

    }

    func goCommentScene() {
        print("goCommentScene") //kimuranow
        

    }

    func settingUIForOptions() {
        settingButton(option1)
        settingButton(option2)
        settingButton(option3)
        settingButton(option4)

        option1.setTitle("還好", for: .normal)
        option2.setTitle("車速過快", for: .normal)
        option3.setTitle("態度不佳", for: .normal)
        option4.setTitle("爛透了", for: .normal)
    }
    func settingButton(_ b: UIButton) {

        b.clipsToBounds = true
        b.layer.cornerRadius = b.frame.size.height / 2.0
        b.layer.borderWidth = 2.0
        b.layer.borderColor = UIColor.black.cgColor
        b.setTitleColor(UIColor.black, for: .normal)
        b.backgroundColor = UIColor.clear
    }

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

     
    // MARK: =================> button

    @IBAction func submitButtonPressed(_ sender: UIButton) {
        callAPIToPostTraceRoutes()
    }
    
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

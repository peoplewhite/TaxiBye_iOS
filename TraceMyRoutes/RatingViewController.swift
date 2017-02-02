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

//
//  RatingViewController.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/1/24.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func backToInitFirstScene() {
        _ = navigationController?.popToRootViewController(animated: true)
    }

}

extension RatingViewController {
    // MARK: =================> button

    @IBAction func submitButtonPressed(_ sender: UIButton) {
        callAPIToPostTraceRoutes()
    }
}
extension RatingViewController {
    // MARK: =================> API

    func callAPIToPostTraceRoutes() {

        API.postTraceRoutes(withKML: KMLMachine.shared.kmlFile,
                            andCarPlateNumber: "",
                            andRatingNumber: 5,
                            success: { (message) in backToInitFirstScene()
                                backToInitFirstScene()

        },
                            fail: { (errorMessage) in
                                print("fail") //kimuranow

        })
    }
}

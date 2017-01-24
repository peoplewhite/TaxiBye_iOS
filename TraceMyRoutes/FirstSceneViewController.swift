//
//  FirstSceneViewController.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/1/24.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import UIKit

class FirstSceneViewController: UIViewController {
    
    @IBOutlet weak var trackButton: UIButton!

    @IBOutlet weak var typeCarPlateNumberTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    override func viewWillAppear(_ animated: Bool) {

        typeCarPlateNumberTextfield.becomeFirstResponder()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func typeCarPlateNumberEditingChanged(_ sender: UITextField) {
        trackButton.isEnabled = (sender.text?.characters.count)! > 0


    }



}

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

        TraceRouteMachine.shared.initMachine()

        makeTypeCarPlateNumberTextfieldShowKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
extension FirstSceneViewController {
    // MARK: =================> textfield

    @IBAction func typeCarPlateNumberEditingChanged(_ sender: UITextField) {

        let trimmedString = sender.text!.trimmingCharacters(in: .whitespaces)

        trackButton.isEnabled = trimmedString.characters.count > 0
        TraceRouteMachine.shared.carPlateNumber = trackButton.isEnabled ? "" : trimmedString

    }

    func makeTypeCarPlateNumberTextfieldEmpty() {
        typeCarPlateNumberTextfield.text = ""
    }

    func makeTypeCarPlateNumberTextfieldShowKeyboard() {
        typeCarPlateNumberTextfield.becomeFirstResponder()
    }
    
}
extension FirstSceneViewController {
    // MARK: =================> button

    @IBAction func trackButtonPressed(_ sender: UIButton) {
        makeTypeCarPlateNumberTextfieldEmpty()
    }
    
}

//
//  StartTraceViewController.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/1/24.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import UIKit

class StartTraceViewController: UIViewController {
    
    @IBOutlet weak var trackButton: UIButton!
    @IBOutlet weak var typeCarPlateNumberTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    override func viewWillAppear(_ animated: Bool) {

        TraceRouteMachine.shared.initMachine()

        makeTypeCarPlateNumberTextfieldShowKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
extension StartTraceViewController {
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
extension StartTraceViewController {
    // MARK: =================> button

    @IBAction func trackButtonPressed(_ sender: UIButton) {
        makeTypeCarPlateNumberTextfieldEmpty()
    }
    
}

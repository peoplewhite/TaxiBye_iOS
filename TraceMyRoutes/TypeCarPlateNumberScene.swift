//
//  TypeCarPlateNumberScene.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/2/23.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import UIKit

class TypeCarPlateNumberScene: UIView {

    @IBOutlet weak var firstPartTextfield: UITextField!
    @IBOutlet weak var secondPartTextfield: UITextField!

    let screenSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)


    // MARK: - setting zone


    @IBAction func exitButtonPressed(_ sender: UIButton) {
        exitScene()
    }

    override func awakeFromNib() {

        firstPartTextfield.becomeFirstResponder()
        
        initValue()

        initUI()

    }

    func initValue() {

    }

    func initUI() {

    }


    func exitScene() {

        endEditing(true)
        
        let kDoubleAnimationDuration: Double = 0.3

        UIView.animate(withDuration: kDoubleAnimationDuration, animations: {() -> Void in

            self.alpha = 0.0

        }, completion: {(finished: Bool) -> Void in

            self.removeFromSuperview()
            
        })
        
    }
    
    
    // MARK: - set UI
    
    
    // MARK: - set value
}

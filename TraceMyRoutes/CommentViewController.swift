//
//  CommentViewController.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/2/2.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {



    @IBOutlet weak var textview: UITextView!





    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    override func viewWillAppear(_ animated: Bool) {
        initUI()
        textview.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func initUI() {
        textview.clipsToBounds = true
        textview.layer.cornerRadius = 6.0
        textview.layer.borderColor = UIColor.black.cgColor
        textview.layer.borderWidth = 2.0
    }


}

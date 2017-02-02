//
//  CommentViewController.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/2/2.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var fakePlaceholder: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        textview.delegate = self

    }
    override func viewWillAppear(_ animated: Bool) {
        
        initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func initUI() {
        textview.becomeFirstResponder()
        settingUIForNavigationBar()
        
        textview.clipsToBounds = true
        textview.layer.cornerRadius = 6.0
        textview.layer.borderColor = UIColor.black.cgColor
        textview.layer.borderWidth = 2.0
    }

    func settingUIForNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationItem.title = "留言"
        navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName:UIColor.white
        ]

        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
    }

    func textViewDidChange(_ textView: UITextView) {
        let trimmedString = textView.text!.trimmingCharacters(in: .whitespaces)
        fakePlaceholder.isHidden = trimmedString.characters.count > 0
    }
}

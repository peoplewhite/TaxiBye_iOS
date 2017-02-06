//
//  BlackListViewController.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/2/6.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import UIKit

class BlackListViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var prefersStatusBarHidden: Bool {
        return true

    }

    override func viewWillAppear(_ animated: Bool) {

        setupTitleLabel()
    }
    func setupTitleLabel() {
        titleLabel.font = titleLabel.font.withSize(AppConfig.titleInBlackListSceneFontSize)
    }
    
    @IBAction func exitButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}

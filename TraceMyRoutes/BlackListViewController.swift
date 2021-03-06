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
    @IBOutlet weak var tableView: UITableView!


    let kCellIdentifierForTableView = "BlackListCell"
    var taxi = Taxi()
    var tempCarPlatenumberUserSelect = ""
    var ratingUnit: String {
        return NSLocalizedString("blackListSceneRatingUnit", comment: "")
    }

    var ratingLavelTitle: [String] {
        return [
            "0\(ratingUnit)",
            "1\(ratingUnit)",
            "2\(ratingUnit)",
            "3\(ratingUnit)",
            "4\(ratingUnit)",
            "5\(ratingUnit)"
        ]
    }
    

    var ratingTaxis = [
        [Taxi](), [Taxi](), [Taxi](), [Taxi](), [Taxi](), [Taxi]()
    ]

    func setupDefaultForRatingTaxis() {
        ratingTaxis = [ [Taxi](), [Taxi](), [Taxi](), [Taxi](), [Taxi](), [Taxi]() ]
    }



    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewWillAppear(_ animated: Bool) {

        navigationController?.setNavigationBarHidden(true, animated: false)

        setupTitleLabel()
        setupTableview()
        callAPIToGetBlackList()

    }
    func setupTitleLabel() {
        titleLabel.font = titleLabel.font.withSize(AppConfig.titleInBlackListSceneFontSize)
        titleLabel.text = NSLocalizedString("blackListSceneTitle", comment: "")
    }
    



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goRatingDetailScene" {
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem


            let ratingDetailViewController = segue.destination as! RatingDetailViewController
            ratingDetailViewController.carPlateNumber = tempCarPlatenumberUserSelect

        }
    }
}
extension BlackListViewController {
    // MARK: =================> button

    @IBAction func exitButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
extension BlackListViewController {
    // MARK: =================> API
    
    func callAPIToGetBlackList() {

        API.fetchRankingList(completion: {


            let taxis = Taxi.mr_findAll()
            self.setupDefaultForRatingTaxis()
            
            taxis?.forEach { taxi in
                let taxiModel: Taxi = taxi as! Taxi
                if let avgRating = taxiModel.avg_rating?.doubleValue {
                    let ratingLevelInteger = Int(floor(avgRating))
                    self.ratingTaxis[ratingLevelInteger].append(taxiModel)
                    print(" = \(ratingLevelInteger) <- \(taxiModel.plate_number)") //kimuranow
                }

            }

            self.tableView.reloadData()
            

        }) { (errorMessage) in
            print("\(#function) Fail: errorMessage = \(errorMessage)") //kimuranow

        }
        
    }
    
}
extension BlackListViewController {
    // MARK: =================> tableview (render)
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let header = UIView()
        header.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 20.0)
        let label = UILabel()
        label.text = ratingLavelTitle[section]
        label.frame = header.frame
        label.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        label.textColor = UIColor.white
        label.textAlignment = .center
        header.addSubview(label)

        return header
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BlackListCell  = tableView.dequeueReusableCell(withIdentifier: kCellIdentifierForTableView, for: indexPath as IndexPath) as! BlackListCell
        cell.selectionStyle = .none

        cell.carPlateNumber.text = ratingTaxis[indexPath.section][indexPath.row].plate_number
        cell.ratingNumber.text = ratingTaxis[indexPath.section][indexPath.row].avg_rating?.description

        return cell
    }
}
extension BlackListViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: =================> tableview

    func setupTableview() {
        tableView.register(UINib(nibName: kCellIdentifierForTableView, bundle: nil), forCellReuseIdentifier: kCellIdentifierForTableView)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return ratingLavelTitle.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratingTaxis[section].count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tempCarPlatenumberUserSelect = ratingTaxis[indexPath.section][indexPath.row].plate_number!
        performSegue(withIdentifier: "goRatingDetailScene", sender: nil)
    }
}

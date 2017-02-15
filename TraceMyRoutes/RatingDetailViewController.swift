//
//  RatingDetailViewController.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/2/14.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import UIKit

class RatingDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {



    @IBOutlet weak var averageRatingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!


    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!

    let kCellIdentifier = "RatingDetailCell"

    var ratings = [Rating]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setTableview()

        API.fetchTaxiDetailInfo(withTaxiPlateNumber: "t", completion: {
            //
            
            let taxiModel = Taxi.mr_findFirst(byAttribute: "plate_number", withValue: "t")
            print("kimura check count 1  = \(taxiModel?.ratings?.count)") //kimuranow

            self.ratings = (taxiModel?.ratings?.allObjects as? [Rating])!

            print("kimura check count = \(self.ratings.count)") //kimuranow
            
            self.tableView.reloadData()


            
        }, fail: { (error) in
            //
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func setTableview() {

        tableView.register(UINib(nibName: kCellIdentifier, bundle: nil), forCellReuseIdentifier: kCellIdentifier)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratings.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RatingDetailCell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath as IndexPath) as! RatingDetailCell
        cell.selectionStyle = .none
        cell.setRatingModel(ratings[indexPath.row])

        return cell

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 97.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}

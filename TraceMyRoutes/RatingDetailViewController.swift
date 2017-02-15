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

        callAPIToFetchTaxiDetailInfo()
    }

    func callAPIToFetchTaxiDetailInfo() {

        API.fetchTaxiDetailInfo(withTaxiPlateNumber: "t", completion: {
            self.fetchTaxiInfoFromCoreDataForTableviewDataSource()
        }, fail: { (error) in
            //
        })
    }
    func fetchTaxiInfoFromCoreDataForTableviewDataSource() {
        let taxiModel = Taxi.mr_findFirst(byAttribute: "plate_number", withValue: "t")
        self.ratings = (taxiModel?.ratings?.allObjects as? [Rating])!
        self.tableView.reloadData()


        averageRatingLabel.text = taxiModel?.avg_rating?.description
        setRatingValue((taxiModel?.avg_rating?.doubleValue)!)

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

    func setRatingValue(_ rating: Double) {

        let halfStarImage = UIImage(named: "blackHalfStar")
        let fullStarImage = UIImage(named: "blackFullStar")
        let emptyStarImage = UIImage(named: "blackEmptyStar")

        star1.image = emptyStarImage
        star2.image = emptyStarImage
        star3.image = emptyStarImage
        star4.image = emptyStarImage
        star5.image = emptyStarImage

        switch rating {
        case 0.0:
            break
        case 0.5:
            star1.image = halfStarImage
            break
        case 1.0:
            star1.image = fullStarImage
            break
        case 1.5:
            star1.image = fullStarImage
            star2.image = halfStarImage
            break
        case 2.0:
            star1.image = fullStarImage
            star2.image = fullStarImage
            break
        case 2.5:
            star1.image = fullStarImage
            star2.image = fullStarImage
            star3.image = halfStarImage
            break
        case 3.0:
            star1.image = fullStarImage
            star2.image = fullStarImage
            star3.image = fullStarImage
            break
        case 3.5:
            star1.image = fullStarImage
            star2.image = fullStarImage
            star3.image = fullStarImage
            star4.image = halfStarImage
            break
        case 4.0:
            star1.image = fullStarImage
            star2.image = fullStarImage
            star3.image = fullStarImage
            star4.image = fullStarImage
            break
        case 4.5:
            star1.image = fullStarImage
            star2.image = fullStarImage
            star3.image = fullStarImage
            star4.image = fullStarImage
            star5.image = halfStarImage
            break
        case 5.0:
            star1.image = fullStarImage
            star2.image = fullStarImage
            star3.image = fullStarImage
            star4.image = fullStarImage
            star5.image = fullStarImage
            break
        default:
            if rating > 0.0 && rating < 0.9 {
                star1.image = halfStarImage
            } else if rating > 1.0 && rating < 1.9 {
                star1.image = fullStarImage
                star2.image = halfStarImage
            } else if rating > 2.0 && rating < 2.9 {
                star1.image = fullStarImage
                star2.image = fullStarImage
                star3.image = halfStarImage
            } else if rating > 3.0 && rating < 3.9 {
                star1.image = fullStarImage
                star2.image = fullStarImage
                star3.image = fullStarImage
                star4.image = halfStarImage
            } else if rating > 4.0 && rating < 4.9 {
                star1.image = fullStarImage
                star2.image = fullStarImage
                star3.image = fullStarImage
                star4.image = fullStarImage
                star5.image = halfStarImage
            }
            break
        }

    }
}

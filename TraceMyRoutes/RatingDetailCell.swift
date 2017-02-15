//
//  RatingDetailCell.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/2/15.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import UIKit

class RatingDetailCell: UITableViewCell {

    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    @IBOutlet weak var feelingTitleLabel: UILabel!
    @IBOutlet weak var ratingMessageLabel: UILabel!
    @IBOutlet weak var allView: UIView!

    let screenSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }



    // MARK: - setting zone



    override func awakeFromNib() {

        initUI()

    }

    func initUI() {
        setAllViewAppearance()

    }

    func setAllViewAppearance() {
        allView.clipsToBounds = true
        allView.layer.borderColor = UIColor.black.cgColor
        allView.layer.borderWidth = 1.0
        allView.layer.cornerRadius = 6.0
        
    }
    func setRatingModel(_ rating: Rating) {
        feelingTitleLabel.text = rating.trip_feeling
        ratingMessageLabel.text = rating.message
    }


    
    
    // MARK: - set UI
    
    
    // MARK: - set value

}

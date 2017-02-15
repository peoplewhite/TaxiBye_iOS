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

    let halfStarImage = UIImage(named: "blackHalfStar")
    let fullStarImage = UIImage(named: "blackFullStar")
    let emptyStarImage = UIImage(named: "blackEmptyStar")

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
        setRatingValue(rating.score)
    }

    func setRatingValue(_ rating: Double) {

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
            break
        }

    }

    
    
    // MARK: - set UI
    
    
    // MARK: - set value

}

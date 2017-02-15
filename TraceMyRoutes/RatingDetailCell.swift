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

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

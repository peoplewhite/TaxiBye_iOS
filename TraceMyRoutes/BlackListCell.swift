//
//  BlackListCell.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/2/6.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import UIKit

class BlackListCell: UITableViewCell {


    @IBOutlet weak var ratingNumber: UILabel!
    @IBOutlet weak var carPlateNumber: UILabel!


    var taxiModel = Taxi()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupTaxi(_ taxi: Taxi) {

        taxiModel = taxi

        ratingNumber.text = taxiModel.avg_rating.description
        carPlateNumber.text = taxiModel.plate_number

    }
}

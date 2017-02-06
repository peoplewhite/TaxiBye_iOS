//
//  AppConfig.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/1/24.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import Foundation
import UIKit


struct AppConfig {


    static let isShowAPILog = false
    static let isUsingGPX = true

    static let emergencyPhoneNumber = "0932453801"



    static let blackFullStarImage = UIImage(named: "blackFullStar")
    static let blackEmptyStarImage = UIImage(named: "blackEmptyStar")
    static let fullStarImage = UIImage(named: "fullStar")
    static let halfStarImage = UIImage(named: "halfStar")
    static let emptyStarImage = UIImage(named: "emptyStar")
    

    static var buttonHeight: CGFloat {
        if UIScreen.main.bounds.size.width == 320.0 {
            return 50.0
        } else if UIScreen.main.bounds.size.width == 375.0 {//iPhone 6
            return 59.0
        } else {//iPhone 6 plus
            return 65.0
        }
    }
    static var searchbuttonInFirstSceneHeight: CGFloat {
        if UIScreen.main.bounds.size.width == 320.0 {
            return 45.0
        } else if UIScreen.main.bounds.size.width == 375.0 {//iPhone 6
            return 53.0
        } else {//iPhone 6 plus
            return 59.0
        }
    }
    static var buttonInWarningSceneSize: CGSize {
        if UIScreen.main.bounds.size.width == 320.0 {
            return CGSize(width: 136.0, height: 50.0)
        } else if UIScreen.main.bounds.size.width == 375.0 {//iPhone 6
            return CGSize(width: 160.0, height: 59.0)
        } else {//iPhone 6 plus
            return CGSize(width: 176.0, height: 60.0)
        }
    }

    static var commentTextViewSize: CGFloat {
        if UIScreen.main.bounds.size.width == 320.0 {
            return 108.0
        } else if UIScreen.main.bounds.size.width == 375.0 {//iPhone 6
            return 127.0
        } else {//iPhone 6 plus
            return 140.0
        }
    }
    static var noButtonInConfirmEmergencyPhoneCallSceneHeight: CGFloat {
        if UIScreen.main.bounds.size.width == 320.0 {
            return 44.0
        } else if UIScreen.main.bounds.size.width == 375.0 {//iPhone 6
            return 52.0
        } else {//iPhone 6 plus
            return 57.0
        }
    }

}

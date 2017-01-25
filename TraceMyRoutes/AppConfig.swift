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


    static var buttonHeight: CGFloat {
        if UIScreen.main.bounds.size.width == 320.0 {
            return 50.0
        } else if UIScreen.main.bounds.size.width == 375.0 {//iPhone 6
            return 59.0
        } else {//iPhone 6 plus
            return 65.0
        }
    }
    
}

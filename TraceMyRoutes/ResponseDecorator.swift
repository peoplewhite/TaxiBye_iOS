//
//  ResponseDecorator.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/2/6.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit


class ResponseDecorator {


    static func createTripRecord(_ response: JSON) {
        

    }
    
    static func queryTaxiByLicensePlateNumber(_ response: JSON) -> Taxi {
        /*
        {
            "data": {
                "plateNumber": "7788-KM",
                "driver": "木村",
                "avgRating": 1.8
            },
            "errors": [],
            "meta": {}
        }
         */

        return Taxi()

    }
    static func fetchRankingList(_ response: JSON) -> TaxiCompany {

        /*
        {
            "data": {
                "taxis": [
                {
                "plateNumber": "7788-KM",
                "driver": "木村",
                "avgRating": 1.8
                }
                ]
            },
            "errors": [],
            "meta": {}
        }
        */


        let taxiCompany = TaxiCompany()
//        let taxis = [Taxi]()
//
//        response["data", "taxis"].arrayValue.forEach { taxi in
//
//            let taxiModel = Taxi()
//
//
//            taxiCompany.append(taxiModel)
//        }


        return taxiCompany
    }
    
    
    
}

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
    
//    static func queryTaxiByLicensePlateNumber(_ response: JSON) -> Taxi {
    static func queryTaxiByLicensePlateNumber(_ response: JSON) {
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
    static func fetchRankingList(_ response: JSON, completion: (() -> Void)) -> Void {

        /*
         {
             "data": [
                 {
                     "id": "1234-XD",
                     "type": "taxis",
                     "attributes": {
                         "plateNumber": "1234-XD",
                         "driver": "",
                         "avgRating": "0.0",
                         "updatedAt": 1486470782
                     }
                 }
             ],
             "meta": {
                 "limit": 10,
                 "count": 1
             }
         }
        */



//        response["data"].arrayValue.forEach { taxi in
//
//            let taxiModel = Taxi()
//            taxiModel.plate_number = taxi["attributes", "plateNumber"].stringValue
//            taxiModel.driver = taxi["attributes", "driver"].stringValue
//            taxiModel.avg_rating = taxi["attributes", "avgRating"].doubleValue
//            taxiModel.updated_at = NSDate(timeIntervalSince1970: taxi["attributes", "updatedAt"].doubleValue)
//
//            RealmMachine.saveTaxi(taxiModel)
//
//        }

        completion()

    }
    
    
    
}

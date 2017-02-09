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


    }
    static func fetchRankingList(_ response: JSON, completion: (() -> Void)) -> Void {

        print("[\(#function)] response = \(response)") //kimuranow

        response["data"].arrayValue.forEach { taxi in

            let plateNumber = taxi["attributes", "plateNumber"].stringValue

            if let _taxiModel = Taxi.mr_findFirst(byAttribute: "plate_number", withValue: plateNumber) {

                _taxiModel.plate_number = plateNumber
                _taxiModel.driver = taxi["attributes", "driver"].stringValue 
                _taxiModel.avg_rating = NSDecimalNumber(floatLiteral: taxi["attributes", "avgRating"].doubleValue)
                _taxiModel.updated_at = NSDate(timeIntervalSince1970: taxi["attributes", "updatedAt"].doubleValue)

            } else {

                let taxiModel = Taxi.mr_createEntity()
                taxiModel?.plate_number = plateNumber
                taxiModel?.driver = taxi["attributes", "driver"].stringValue
                taxiModel?.avg_rating = NSDecimalNumber(floatLiteral: taxi["attributes", "avgRating"].doubleValue)
                taxiModel?.updated_at = NSDate(timeIntervalSince1970: taxi["attributes", "updatedAt"].doubleValue)
            }
            

            NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()

        }

        completion()

    }
    
    
    
}

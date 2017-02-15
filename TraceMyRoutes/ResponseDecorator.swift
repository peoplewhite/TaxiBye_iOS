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
        print("[\(#function)] response = \(response)") //kimuranow


    }

    static func fetchTaxiDetailInfo(_ response: JSON, completion: (() -> Void)) -> Void {
        print("[\(#function)] response = \(response)") //kimuranow

        let taxiModel = Taxi.mr_findFirst(byAttribute: "plate_number", withValue: response["data", "attributes", "plateNumber"].stringValue)

        response["included"].arrayValue.forEach { rating in

            let ratingID = rating["id"].intValue

            if let _ratingModel = Rating.mr_findFirst(byAttribute: "id", withValue: ratingID) {

                _ratingModel.id = Int32(ratingID)
                _ratingModel.message = rating["attributes", "message"].stringValue
                _ratingModel.score = rating["attributes", "score"].doubleValue
                _ratingModel.update_at = NSDate(timeIntervalSince1970: rating["attributes", "updatedAt"].doubleValue)
                _ratingModel.trip_feeling = rating["attributes", "tripFeeling"].stringValue

                print("A.message = \(_ratingModel.message): \(_ratingModel.trip_feeling)") //kimuranow
                taxiModel?.addToRatings(_ratingModel)

            } else {

                if let ratingModel = Rating.mr_createEntity() {

                    ratingModel.id = Int32(ratingID)
                    ratingModel.message = rating["attributes", "message"].stringValue
                    ratingModel.score = rating["attributes", "score"].doubleValue
                    ratingModel.update_at = NSDate(timeIntervalSince1970: rating["attributes", "updatedAt"].doubleValue)
                    ratingModel.trip_feeling = rating["attributes", "tripFeeling"].stringValue

                print("B.message = \(ratingModel.message)") //kimuranow
                    taxiModel?.addToRatings(ratingModel)
                }
            }


        }

        print("kimura check count in responseDecorator = \(taxiModel?.ratings?.count)") //kimuranow
        
        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
        completion()
    }
    
    static func queryTaxiByLicensePlateNumber(_ response: JSON) -> Taxi {

        print("[\(#function)] response = \(response)") //kimuranow

        let taxi = Taxi.mr_createEntity()
        taxi?.plate_number = response["data", "attributes", "plateNumber"].stringValue
        taxi?.driver = response["data", "attributes", "driver"].stringValue
        taxi?.avg_rating = NSDecimalNumber(floatLiteral: response["data", "attributes", "avgRating"].doubleValue)

        return taxi!
        
    }

    static func fetchFeelingList(_ response: JSON, completion: (() -> Void)) -> Void {
        print("[\(#function)] response = \(response)") //kimuranow

        response["data"].arrayValue.forEach { feeling in

            let feelingID = feeling["id"].intValue

            if let _feelingModel = Feeling.mr_findFirst(byAttribute: "id", withValue: feelingID) {

                _feelingModel.id = Int32(feelingID)
                _feelingModel.title = feeling["attributes", "title"].stringValue

            } else {

                let feelingModel = Feeling.mr_createEntity()
                feelingModel?.id = Int32(feelingID)
                feelingModel?.title = feeling["attributes", "title"].stringValue
            }


            NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
        }

        completion()
        
    }
    static func fetchRankingList(_ response: JSON, completion: (() -> Void)) -> Void {

        print("[\(#function)] response = \(response)") //kimuranow

        response["data"].arrayValue.forEach { taxi in

            let plateNumber = taxi["attributes", "plateNumber"].stringValue
            print("plateNumber = \(plateNumber)") //kimuranow
                    print("VVV===============") //kimuranow
                    print("find, edit") //kimuranow
//                    print(" = \(taxi.plate_number)") //kimuranow
//                    print(" = \(taxi.driver)") //kimuranow
//                    print(" = \(taxi.avg_rating)") //kimuranow
//                    print(" = \(taxi.updated_at)") //kimuranow
                    print("^^^===============") //kimuranow

            if let _taxiModel = Taxi.mr_findFirst(byAttribute: "plate_number", withValue: plateNumber) {

                if _taxiModel.plate_number == "t" {
                    print("VVV===============") //kimuranow
                    print("find, edit") //kimuranow
                    print(" = \(_taxiModel.plate_number)") //kimuranow
                    print(" = \(_taxiModel.driver)") //kimuranow
                    print(" = \(_taxiModel.avg_rating)") //kimuranow
                    print(" = \(_taxiModel.updated_at)") //kimuranow
                    print("^^^===============") //kimuranow
                }
                
                _taxiModel.plate_number = plateNumber
                _taxiModel.driver = taxi["attributes", "driver"].stringValue 
                _taxiModel.avg_rating = NSDecimalNumber(floatLiteral: taxi["attributes", "avgRating"].doubleValue)
                _taxiModel.updated_at = NSDate(timeIntervalSince1970: taxi["attributes", "updatedAt"].doubleValue)


                if _taxiModel.plate_number == "t" {
                    print("VVV===============") //kimuranow
                    print("after update") //kimuranow
                    print(" = \(_taxiModel.plate_number)") //kimuranow
                    print(" = \(_taxiModel.driver)") //kimuranow
                    print(" = \(_taxiModel.avg_rating)") //kimuranow
                    print(" = \(_taxiModel.updated_at)") //kimuranow
                    print("^^^===============") //kimuranow
                }
                // Taxi.updateOrCreate()

            } else {
                print("can't find, create") //kimuranow

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

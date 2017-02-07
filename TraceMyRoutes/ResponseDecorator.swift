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
        /*
        {
            "data": {
                "id": "24",
                "type": "trips",
                "attributes": {
                    "startedAt": 1486453039,
                    "endedAt": 1486453039,
                    "route": "abcdefg",
                    "updatedAt": 1486453039
                },
                "relationships": {
                    "rating": {
                        "data": {
                            "id": "24",
                            "type": "ratings"
                        }
                    },
                    "taxi": {
                        "data": {
                            "id": "1234-XD",
                            "type": "taxis"
                        }
                    }
                }
            },
            "included": [
                {
                  "id": "24",
                  "type": "ratings",
                  "attributes": {
                      "score": "5.0",
                      "message": "還可以",
                      "tripFeeling": "fine",
                      "updatedAt": 1486453039
                   }
                },
                {
                  "id": "1234-XD",
                  "type": "taxis",
                  "attributes": {
                      "plateNumber": "1234-XD",
                      "driver": "",
                      "avgRating": "4.6",
                      "updatedAt": 1486453018
                    }
                }
            ]
        }
 */

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

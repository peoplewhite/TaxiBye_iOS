//
//  API.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/1/24.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import iOS_KML_Framework


class API {

    let hostURL = "http://taxibye.oddesign.expert"

    var baseURL: String {
        return "\(hostURL)/api"
    }
    var termURL: String {
        return "\(hostURL)/term"
    }
    var policyURL: String {
        return "\(hostURL)/policy"
    }

    let version = "/v1"
    let strEndPointCreateItemPhoto = "/user/item_photos"

//    var headers: [String: String] {
//        return ["Email": MyUser.sharedInstance.email, "Token": MyUser.sharedInstance.token]
//    }


    class var sharedInstance : API {
        struct Static {
            static let instance : API = API()
        }
        return Static.instance
    }

}
extension API {
    // MARK: =================> comment

    static func fetchRankingList() {

    }
    static func queryTaxiByLicensePlateNumber() {
        
    }
    static func createTripRecord() {
        
    }

    static func postTraceRoutes(withKML kml: KMLDocument, andCarPlateNumber carPlateNumber: String, andRatingNumber ratingNumber: Int, success:((String) -> Void), fail:((String) -> Void)) {
        
        success("ok")
        
    }

//    func createComment(withTagID tagID: Int, andItemPhotoID itemPhotoID: Int, andContent content: String, success: @escaping (() -> Void), fail: @escaping ((String) -> Void)) {
//
//        DataDecorator.sharedInstance.showTitle("create comment")
//
//        let dictParams: [String : String] = [
//            "email": MyUser.sharedInstance.email,
//            "token": MyUser.sharedInstance.token,
//            // TODO: 沒針對單張tag留comment
//            //      "price_tag_id": "\(tagID)",
//            "content": content
//        ]
//
//        let strPostsEndPoint = baseURL + version + "/item_photo/\(itemPhotoID)/comments"
//
//        DataDecorator.sharedInstance.showParams(dictParams.description)
//
//        Alamofire.request(strPostsEndPoint, method: .post, parameters: dictParams , encoding: JSONEncoding.default)
//            .responseJSON { response in
//                guard response.result.error == nil else {
//                    fail(response.result.error.debugDescription)
//                    return
//                }
//
//                if let value: AnyObject = response.result.value as AnyObject? {
//                    let result = DataDecorator.sharedInstance.handleActionResult(JSON(value), andActionTitle: #function)
//                    if result.isSuccess {
//                        success()
//                    } else {
//                        fail(result.errorMessage)
//                    }
//                }
//        }
//
//    }
}

extension API {

    enum APIMethod {
        case fetchRankingList
        case queryTaxiByLicensePlateNumber
        case createTripRecord
    }

    func getEndPoint(with method: APIMethod) -> String {

        var endPoint = ""

        switch method {

        case .fetchRankingList:
            endPoint = "/taxis/ranking?number="
            break
        case .queryTaxiByLicensePlateNumber:
            endPoint = "/taxis/license_plate_number"
            break
        case .createTripRecord:
            endPoint = "/taxis/license_plate_number/trips"
            break
        }
        
        return baseURL + version + endPoint
        
    }
    
    func getShareItemPhotoURL(_ hash: String) -> String {
        
        return hostURL + "/item_photos/" + hash
        
    }
}
extension API {
    
    enum APILogType: String {
        case start = "start"
        case params = "parameters"
        case header = "header"
        case url = "url"
    }
    
    
    func printResponse(withContent response: String, andFunctionName functionName: String) {
        
        guard AppConfig.isShowAPILog else {
            return
        }
        
        let content = "\n[API][\(functionName)] Response \n \(response)"
        
        print(content)
        
    }
    
    func printParams(withParameters params: String = "", andHeaders headers: String = "", andURL url: String, andFunctionName functionName: String) {
        
        guard AppConfig.isShowAPILog else {
            return
        }
        
        var content = "\n[API][\(functionName)] Parameters"
        content += "\n - parameters = \(params != "" ? params : "no value")"
        content += "\n - headers    = \(headers != "" ? headers : "no value")"
        content += "\n - url        = \(url)"
        
        print(content)
    }
    
}


struct APIActionResult {
    var errorMessage = ""
    var isSuccess = false
}




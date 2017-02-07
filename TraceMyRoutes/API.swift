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

//    var headers: [String: String] {
//        return ["Email": MyUser.sharedInstance.email, "Token": MyUser.sharedInstance.token]
//    }



}
extension API {
    // MARK: =================>

    static func fetchRankingList(completion: ((_ taxiCompany: TaxiCompany)-> Void), fail: @escaping ((_ errorMessage: String) -> Void)) {

        let url = "http://taxibye.oddesign.expert/api/v1/taxis/ranking?number="

//        printParams(andURL: url, andFunctionName: #function)

        Alamofire.request( url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                guard response.result.error == nil else {
                    fail(response.result.error.debugDescription)
                    return
                }

                if let value: AnyObject = response.result.value as AnyObject? {
                    print("value = \(value)") //kimuranow
//                    completion()
                }
        }
    }

    static func queryTaxiByLicensePlateNumber(completion: (()-> Void), fail: @escaping ((_ errorMessage: String) -> Void)) {

        let url = "http://taxibye.oddesign.expert/api/v1/taxis/license_plate_number"
        
        Alamofire.request( url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                guard response.result.error == nil else {
                    fail(response.result.error.debugDescription)
                    return
                }

                if let value: AnyObject = response.result.value as AnyObject? {
                    print("value = \(value)") //kimuranow
//                    completion()
                }
        }
        
    }


    static func createTripRecord(completion: (()-> Void), fail: @escaping ((_ errorMessage: String) -> Void)) {

        let url = "http://taxibye.oddesign.expert/api/v1/taxis/license_plate_number/trips"
        
        Alamofire.request( url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                guard response.result.error == nil else {
                    fail(response.result.error.debugDescription)
                    return
                }

                if let value: AnyObject = response.result.value as AnyObject? {
                    print("value = \(value)") //kimuranow
//                    completion()
                }
        }

    }
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




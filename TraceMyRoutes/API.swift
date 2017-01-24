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

    let hostURL = "http://pt.oddesign.expert"

    var baseURL: String {
        return "\(hostURL)/api"
    }
    var termURL: String {
        return "\(hostURL)/term"
    }
    var policyURL: String {
        return "\(hostURL)/policy"
    }

    let version = "/v2"
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

    static func postTraceRoutes(withKML kml: KMLDocument, andCarPlateNumber carPlateNumber: String, andRatingNumber ratingNumber: Int) {
        
        
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
        case facebookLogin
        case normalLogin
        case postNewItemPhoto
        case getMyItemPhoto
        case validateToken
        case logout
        case getAllItemPhoto
        case reportItemPhoto
        case deleteItemPhoto
        case homeSceneTimeline
        case fetchFollowerList
        case fetchFollowingList
    }

    func getEndPoint(with method: APIMethod) -> String {

        var endPoint = ""

        switch method {

        case .facebookLogin:
            endPoint = "/fb_login"
            break
        case .normalLogin:
            endPoint = "/login"
            break
        case .postNewItemPhoto:
            endPoint = "/user/item_photos"
            break
        case .getMyItemPhoto:
            endPoint = "/dashboard/profile"
            break
        case .validateToken:
            endPoint = "/validate_token"
            break
        case .logout:
            endPoint = "/logout"
            break
        case .getAllItemPhoto:
            endPoint = "/item_photo/all"
            break
        case .reportItemPhoto:
            endPoint = "/item_photo/"
            break
        case .deleteItemPhoto:
            endPoint = "/item_photo/"
            break
        case .homeSceneTimeline:
            endPoint = "/timeline"
            break
        case .fetchFollowerList:
            endPoint = "/followers"
            break
        case .fetchFollowingList:
            endPoint = "/following_users"
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




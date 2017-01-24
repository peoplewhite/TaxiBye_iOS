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

    var headers: [String: String] {
        return ["Email": MyUser.sharedInstance.email, "Token": MyUser.sharedInstance.token]
    }


    class var sharedInstance : API {
        struct Static {
            static let instance : API = API()
        }
        return Static.instance
    }

}
extension API {
    // MARK: =================> comment


    func createComment(withTagID tagID: Int, andItemPhotoID itemPhotoID: Int, andContent content: String, success: @escaping (() -> Void), fail: @escaping ((String) -> Void)) {

        DataDecorator.sharedInstance.showTitle("create comment")

        let dictParams: [String : String] = [
            "email": MyUser.sharedInstance.email,
            "token": MyUser.sharedInstance.token,
            // TODO: 沒針對單張tag留comment
            //      "price_tag_id": "\(tagID)",
            "content": content
        ]

        let strPostsEndPoint = baseURL + version + "/item_photo/\(itemPhotoID)/comments"

        DataDecorator.sharedInstance.showParams(dictParams.description)

        Alamofire.request(strPostsEndPoint, method: .post, parameters: dictParams , encoding: JSONEncoding.default)
            .responseJSON { response in
                guard response.result.error == nil else {
                    fail(response.result.error.debugDescription)
                    return
                }

                if let value: AnyObject = response.result.value as AnyObject? {
                    let result = DataDecorator.sharedInstance.handleActionResult(JSON(value), andActionTitle: #function)
                    if result.isSuccess {
                        success()
                    } else {
                        fail(result.errorMessage)
                    }
                }
        }

    }

    func deleteComment() {

    }
    func reportComment() {

    }

}
extension API {
    // MARK: =================> login

    func facebookLogin(_ token: String, name: String, uid: String, email: String) {

        DataDecorator.sharedInstance.showTitle("facebook login")

        let dictParams: [String: String] = [
            "fb_token": token,
            "name": name,
            "uid": uid,
            "email": email
        ]

        DataDecorator.sharedInstance.showParams(dictParams.description)


        Alamofire.request(getEndPoint(with: .facebookLogin), method: .post, parameters: dictParams, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in

                guard response.result.error == nil else {

                    DataDecorator.sharedInstance.showError(response.result.error.debugDescription)

                    return
                }

                if let value: AnyObject = response.result.value as AnyObject? {

                    DataDecorator.sharedInstance.handleFacebookLoginResponse(JSON(value))

                }
        }

    }

    func normalLogin() {

    }

    func validateToken(withEmail email: String, andToken token: String) {

        let url = getEndPoint(with: .validateToken)
        let params: [String: String] = [
            "email": email,
            "token": token
        ]
        printParams(withParameters: params.description, andURL: url, andFunctionName: #function)

        Alamofire.request(url, method: .post, parameters: params ,encoding: JSONEncoding.default)
            .responseJSON { response in
                guard response.result.error == nil else {

                    DataDecorator.sharedInstance.showError(response.result.error.debugDescription)

                    return
                }

                if let value: AnyObject = response.result.value as AnyObject? {

                    DataDecorator.sharedInstance.validateToken(JSON(value))

                }
        }

    }
    func logout() {

        DataDecorator.sharedInstance.showTitle("logout")

        let dictParams = [

            "email": MyUser.sharedInstance.email,
            "token": MyUser.sharedInstance.token
        ]

        DataDecorator.sharedInstance.showParams(dictParams.description)

        DataDecorator.sharedInstance.show(getEndPoint(with: .logout))

        Alamofire.request(
            getEndPoint(with: .logout),
            method: .post,
            parameters: dictParams,
            encoding: JSONEncoding.default,
            headers: nil
            )
            .responseJSON { response in
                guard response.result.error == nil else {

                    DataDecorator.sharedInstance.showError(response.result.error.debugDescription)

                    return
                }

                if let value: AnyObject = response.result.value as AnyObject? {


                    DataDecorator.sharedInstance.handleLogoutResponse(JSON(value))

                }
        }
    }


}
extension API {
    // MARK: =================> follow

    func fetchFollowerList(completion: @escaping (_ followers: [User]) -> Void) {

        let url = "\(baseURL)\(version)/users/\(MyUser.sharedInstance.userid)/followers"

        printParams(andHeaders: headers.description, andURL: url, andFunctionName: #function)

        Alamofire.request( url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // TODO: handle fail
                    return
                }

                if let value: AnyObject = response.result.value as AnyObject? {
                    completion(DataDecorator.sharedInstance.fetchFollowerList(JSON(value)))
                }
        }

    }

    func fetchFollowingList(completion: (_ followrs: [User]) -> Void) {

    }

    func unfollowUser(withUserID followingUserID: String, completion: @escaping ((_ result: APIActionResult) -> Void)) {

        let url = "\(baseURL)\(version)/users/\(MyUser.sharedInstance.userid)/following_user/\(followingUserID)"
        let params: [String : String] = [ "email": MyUser.sharedInstance.email, "token": MyUser.sharedInstance.token ]

        printParams(
            withParameters: params.description,
            andURL: url,
            andFunctionName: #function
        )

        Alamofire.request(url, method: .delete, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                guard response.result.error == nil else {
                    DataDecorator.sharedInstance.showError(response.result.error.debugDescription)
                    return
                }

                if let value: AnyObject = response.result.value as AnyObject? {
                    completion(DataDecorator.sharedInstance.handleActionResult(JSON(value), andActionTitle: "Follow User"))
                }
        }
    }
    func followUser(withUserID followingUserID: String, completion: @escaping ((_ result: APIActionResult) -> Void)) {

        let url = "\(baseURL)\(version)/users/\(MyUser.sharedInstance.userid)/following_user/\(followingUserID)"
        let params: [String : String] = [ "email": MyUser.sharedInstance.email, "token": MyUser.sharedInstance.token ]

        printParams(
            withParameters: params.description,
            andURL: url,
            andFunctionName: #function
        )

        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                guard response.result.error == nil else {
                    DataDecorator.sharedInstance.showError(response.result.error.debugDescription)
                    return
                }

                if let value: AnyObject = response.result.value as AnyObject? {
                    completion(DataDecorator.sharedInstance.handleActionResult(JSON(value), andActionTitle: "Follow User"))
                }
        }
    }
}

extension API {
    // MARK: =================> item photos

    func postNewItemPhoto(_ imgOrigin: UIImage, imgWithBlackTag: UIImage, arrPriceTag: Array<PriceTag>) {

        let url = getEndPoint(with:.postNewItemPhoto)

        let params: [String : AnyObject] = [
            "origin_picture": "data:image/jpg;base64,\(Utils.sharedInstance.encodedImage(imgOrigin))" as AnyObject,
            "tagged_picture": "data:image/jpg;base64,\(Utils.sharedInstance.encodedImage(imgWithBlackTag))" as AnyObject,
            "email": MyUser.sharedInstance.email as AnyObject,
            "token": MyUser.sharedInstance.token as AnyObject,
            "price_tags": Utils.sharedInstance.changePriceTagArrayToParams(arrPriceTag) as AnyObject

        ]

        let paramsForLog: [String: String] = [
            "origin_picture": "Got it",
            "tagged_picture": "Got it",
            "email": MyUser.sharedInstance.email,
            "token": MyUser.sharedInstance.token,
            "price_tags": Utils.sharedInstance.changePriceTagArrayToParams(arrPriceTag).description
        ]

        printParams(
            withParameters: PTConfig.isShowReponseDetailOfPostNewItemPhotos ? params.description : paramsForLog.description,
            andURL: url,
            andFunctionName: #function
        )

        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                guard response.result.error == nil else {

                    DataDecorator.sharedInstance.showError(response.result.error.debugDescription)

                    return
                }

                if let value: AnyObject = response.result.value as AnyObject? {

                    DataDecorator.sharedInstance.postNewItemPhoto(JSON(value))

                }
        }
    }

    func getMyItemPhotos( completion: @escaping (([ItemPhotoFromServer]) -> Void), fail: @escaping ((String) -> Void)) {

        //        let url = getEndPoint(with: .getMyItemPhoto) + "?photos=\(Dashboard.sharedInstance.maximumItemPhotoSumInHomePageScene)&comments=10"
        let url = getEndPoint(with: .getMyItemPhoto)

        printParams(andHeaders: headers.description, andURL: url, andFunctionName: #function)

        Alamofire.request( url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                guard response.result.error == nil else {
                    fail(response.result.error.debugDescription)
                    return
                }

                if let value: AnyObject = response.result.value as AnyObject? {
                    completion(DataDecorator.sharedInstance.getMyItemPhotos(JSON(value)))
                }
        }
    }



    func reportItemPhoto(_ itemPhotoID: Int) {

        DataDecorator.sharedInstance.showTitle("report item photo")

        let dictParams: [String : String] = [
            "email": MyUser.sharedInstance.email,
            "token": MyUser.sharedInstance.token
        ]

        DataDecorator.sharedInstance.showParams(dictParams.description)

        let strPostsEndPoint: String = baseURL + version + "/item_photo/\(itemPhotoID)/report"


        Alamofire.request(strPostsEndPoint, method: .post, parameters: dictParams, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                guard response.result.error == nil else {

                    DataDecorator.sharedInstance.showError(response.result.error.debugDescription)

                    return
                }

                if let value: AnyObject = response.result.value as AnyObject? {

                    DataDecorator.sharedInstance.handleReportItemPhotoResponse(JSON(value))

                }
        }
    }
    func getHomeSceneItemPhoto(completion: @escaping (([ItemPhotoFromServer]) -> Void), fail: @escaping ((String) -> Void)) {

        let headers = ["Email": MyUser.sharedInstance.email, "Token": MyUser.sharedInstance.token]
        let url = getEndPoint(with: .homeSceneTimeline)


        printParams(
            withParameters: headers.description,
            andURL: url,
            andFunctionName: #function
        )

        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in

                guard response.result.error == nil else {
                    fail(response.result.error.debugDescription)
                    return
                }

                if let value: AnyObject = response.result.value as AnyObject? {
                    //                DataDecorator.sharedInstance.handleGetAllItemPhotoResponse(JSON(value))
                    completion(DataDecorator.sharedInstance.getAllItemPhotos(JSON(value)))
                }
        }
    }

    func getAllItemPhoto( completion: @escaping (([ItemPhotoFromServer]) -> Void), fail: @escaping ((String) -> Void)) {

        let dictHeaders = ["Email": MyUser.sharedInstance.email, "Token": MyUser.sharedInstance.token]
        let url = getEndPoint(with: .getAllItemPhoto)

        DataDecorator.sharedInstance.showTitle("get all item photos")
        DataDecorator.sharedInstance.showParams("no params")
        DataDecorator.sharedInstance.show(dictHeaders.description)
        DataDecorator.sharedInstance.show(getEndPoint(with: .getAllItemPhoto))

        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: dictHeaders)
            .responseJSON { response in

                guard response.result.error == nil else {
                    fail(response.result.error.debugDescription)
                    return
                }

                if let value: AnyObject = response.result.value as AnyObject? {
                    //                DataDecorator.sharedInstance.handleGetAllItemPhotoResponse(JSON(value))
                    completion(DataDecorator.sharedInstance.getAllItemPhotos(JSON(value)))
                }
        }
    }

    func deleteItemPhoto(withID itemPhotoID: Int, completion: @escaping ((APIActionResult) -> Void)) {

        DataDecorator.sharedInstance.showTitle("delete item photos")


        let dictHeaders = [

            "Email": MyUser.sharedInstance.email,
            "Token": MyUser.sharedInstance.token
        ]

        DataDecorator.sharedInstance.show(dictHeaders.description)

        let strPostsEndPoint = baseURL + version + "/user/item_photos/\(itemPhotoID)"

        print("strPostsEndPoint = \(strPostsEndPoint)")

        Alamofire.request(strPostsEndPoint, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: dictHeaders).responseJSON { response in

            guard response.result.error == nil else {

                DataDecorator.sharedInstance.showError(response.result.error.debugDescription)

                return
            }

            if let value: AnyObject = response.result.value as AnyObject? {


                completion(DataDecorator.sharedInstance.handleDeleteItemPhotoResponse(JSON(value)))

            }
        }

    }
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
        
        guard PTConfig.isShowAPILog else {
            return
        }
        
        let content = "\n[API][\(functionName)] Response \n \(response)"
        
        print(content)
        
    }
    
    func printParams(withParameters params: String = "", andHeaders headers: String = "", andURL url: String, andFunctionName functionName: String) {
        
        guard PTConfig.isShowAPILog else {
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




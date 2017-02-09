//
//  User.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/2/9.
//  Copyright © 2017年 oddesign. All rights reserved.
//

import Foundation


class User {

}


class MyUser: User {

    class var shared : MyUser {
        struct Static {
            static let instance : MyUser = MyUser()
        }
        return Static.instance
    }

    private var _authToken = ""
    
    var authToken: String {
        get {
            return "Bearer \(_authToken)"
        }
        set(token) {
            _authToken = token
        }
    }

    
    
}

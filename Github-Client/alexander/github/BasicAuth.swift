//
//  BasicAuth.swift
//  github
//
//  Created by Alexander Elbracht on 15.03.16.
//  Copyright © 2016 Alexander Elbracht. All rights reserved.
//

import UIKit

class BasicAuth: NSObject {
    static func sessionConfiguration() -> NSURLSessionConfiguration {
        let username = "username"
        let password = "password or token"
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        let authString = "Basic \(base64LoginString)"
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.HTTPAdditionalHeaders = ["Authorization" : authString]
        return config
    }
}

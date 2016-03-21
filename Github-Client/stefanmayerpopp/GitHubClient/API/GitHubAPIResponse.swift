//
//  GitHubAPIResponse.swift
//  GitHubClient
//
//  Created by Stefan Popp on 12.03.16.
//  Copyright © 2016 Stefan Mayer-Popp. All rights reserved.
//

import UIKit

class GitHubAPIResponse<Result> {
    /// HTTP response of request
    let response: NSHTTPURLResponse?
    /// Original request
    let request: NSURLRequest?
    /// Raw data of request as NSData
    let data: NSData?
    /// Wrapped result object
    let result: GitHubAPIResult<AnyObject>

    /**
     Initialize a response
     
     - parameter response: Response of a request
     - parameter request:  Original request
     - parameter result:   Result wrapped object
     - parameter data:     Raw data of request as NSData
     
     - returns: GitHubAPIResponse object
     */
    init(
        response: NSHTTPURLResponse?,
        request: NSURLRequest?,
        result: GitHubAPIResult<AnyObject>,
        data: NSData?
        ) {
            self.response = response
            self.request = request
            self.data = data
            self.result = result
    }
}
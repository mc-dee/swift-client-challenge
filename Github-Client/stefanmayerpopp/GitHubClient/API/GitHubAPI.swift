//
//  GitHubAPI.swift
//  GitHubClient
//
//  Created by Stefan Popp on 12.03.16.
//  Copyright © 2016 Stefan Mayer-Popp. All rights reserved.
//

import UIKit

/**
 Wrapper for the response object which can be switch for Succes/Failure case.

 - Success: Contains Result object
 - Failure: Contains a failure
 */
enum GitHubAPIResult<Result> {
    case Success(Result)
    case Failure(NSError)
}

/// GitHubAPI 
class GitHubAPI {
    
    // Queue setup
    var URLSession: NSURLSession!
    
    // API URL
    let apiURLString = "https://api.github.com"
    
    init() {
        // Session configuration
        let urlSession = NSURLSessionConfiguration.defaultSessionConfiguration()
        urlSession.timeoutIntervalForRequest = 10
        urlSession.timeoutIntervalForResource = 30
        urlSession.HTTPMaximumConnectionsPerHost = 4
        
        URLSession = NSURLSession(
            configuration: urlSession,
            delegate: nil,
            delegateQueue: OperationManager.sharedInstance.operationQueue
        )
    }
    
    /**
     Request factory
     
     - parameter endpoint: Specifies the endpoint which should be called
     
     - returns: A request object
     */
    static func request(endpoint endpoint: GitHubEndPoint) -> GitHubAPIRequest {
        // Initialize API
        let api = GitHubAPI()
        // Build target url, strip white spaces
        let targetURL = (api.apiURLString + endpoint.string).stringByReplacingOccurrencesOfString(" ", withString: "")
        // Create request URL
        let requestURL = NSURLRequest(URL: NSURL(string: targetURL)!)
        // Return request
        return GitHubAPIRequest(request: requestURL, session: api.URLSession)
    }
}
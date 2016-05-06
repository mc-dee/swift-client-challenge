//
//  GitHubAPI.swift
//  GitHubClient
//
//  Created by Stefan Popp on 12.03.16.
//
//  This file is part of GitHubCLient.
//
//  GitHubCLient is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  GitHubCLient is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with GitHubCLient.  If not, see <http://www.gnu.org/licenses/>./

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
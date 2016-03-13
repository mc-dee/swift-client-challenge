//
//  GitHubAPIRequest.swift
//  GitHubClient
//
//  Created by Stefan Popp on 12.03.16.
//  Copyright © 2016 Stefan Mayer-Popp. All rights reserved.
//

import UIKit

/**
 Error codes of API
 
 - noData:            No data returned
 - noHTTPResponse:    NO HTTP response received
 - noHTTPSuccessCode: Something else then 200 OK status received
 - json:              Invalid or empty json
 */
enum GitHubAPIError: Int {
    case noData
    case noHTTPResponse
    case noHTTPSuccessCode
    case json
}

/// Request for GitHubAPI
class GitHubAPIRequest {
    /// Request we want to fire against API
    let request: NSURLRequest
    /// URL Session to use
    let session: NSURLSession
    /// Session task of URL Session
    private var task: NSURLSessionTask?
    
    /// Type alias for response completion block
    typealias JSONResponseCompletion = GitHubAPIResponse<AnyObject> -> Void
    
    /**
     Init method for a give request and session
     
     - parameter request: Request you want to fire
     - parameter session: session which should be used for request
     
     - returns: GitHubAPIRequest
     */
    init(request: NSURLRequest, session: NSURLSession) {
        self.request = request
        self.session = session
    }
    
    /**
     Starts the request and calls a given completion block if finished.
     Response object contains a GitHubAPIResponse
     
     - parameter completionBlock: Block which should be called on response
     
     - returns: The created request
     */
    func responseJSON(onCompletion completionBlock: JSONResponseCompletion) -> Self {
        task = session.dataTaskWithRequest(request) { (data, URLResponse, error) -> Void in
            
            // Do we have an error?
            guard error == nil else {
                let response = GitHubAPIRequest.makeResponse(
                    URLResponse,
                    request: self.request,
                    result: .Failure(error!),
                    data: data
                )
                return completionBlock(response)
            }
            
            // Do we have data recieved and do we really have some data?
            guard let data = data where data.length > 0 else {
                let error = NSError(domain: "com.github.api", code: GitHubAPIError.noData.rawValue, userInfo: nil)
                let response = GitHubAPIRequest.makeResponse(
                    URLResponse,
                    request: self.request,
                    result: .Failure(error),
                    data: nil
                )
                return completionBlock(response)
            }
            
            // Ensure our response is http url response
            guard let HTTPURLResponse = URLResponse as? NSHTTPURLResponse else {
                let error = NSError(domain: "com.github.api", code: GitHubAPIError.noHTTPResponse.rawValue, userInfo: nil)
                let response = GitHubAPIRequest.makeResponse(
                    URLResponse,
                    request: self.request,
                    result: .Failure(error),
                    data: nil
                )
                return completionBlock(response)
            }
            
            // Ensure our response is valid
            guard HTTPURLResponse.statusCode == 200 else {
                let error = NSError(
                    domain: "com.github.api",
                    code: GitHubAPIError.noHTTPSuccessCode.rawValue,
                    userInfo: [NSLocalizedDescriptionKey : HTTPURLResponse.allHeaderFields["Status"] ?? "Unknown error"]
                )
                let response = GitHubAPIRequest.makeResponse(
                    URLResponse,
                    request: self.request,
                    result: .Failure(error),
                    data: nil
                )
                return completionBlock(response)
            }

            // Convert data to JSON
            do {
                let JSON = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                let response = GitHubAPIRequest.makeResponse(
                    URLResponse,
                    request: self.request,
                    result: .Success(JSON),
                    data: data
                )
                
                dispatch_async(dispatch_get_main_queue()) {
                    completionBlock(response)
                }
            } catch {
                let error = NSError(domain: "com.github.api", code: GitHubAPIError.noData.rawValue, userInfo: nil)
                let response = GitHubAPIRequest.makeResponse(
                    URLResponse,
                    request: self.request,
                    result: GitHubAPIResult<AnyObject>.Failure(error),
                    data: data
                )
                return completionBlock(response)
            }
        }
        // Queue and start request
        task?.resume()
        return self
    }
    
    /**
     Convenience method to create reponse object with required data
     
     - parameter URLResponse: Response of response
     - parameter request:     Original request
     - parameter result:      Result object
     - parameter data:        Raw data of request
     
     - returns: A GitHubAPIResponse 
     */
    private static func makeResponse(
        URLResponse: NSURLResponse?,
        request: NSURLRequest?,
        result: GitHubAPIResult<AnyObject>,
        data: NSData? = nil
        ) -> GitHubAPIResponse<AnyObject> {
        return GitHubAPIResponse<AnyObject>(
            response: (URLResponse as! NSHTTPURLResponse),
            request: request,
            result: result,
            data: data
        )
    }
}

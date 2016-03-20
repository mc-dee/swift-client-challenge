// -------------------------------------------------------
//  GitHubAPI.swift
//  GitHubClientChallenge
//
//  Created by Michael on 13.03.2016.
//  Copyright © 2016 Michael Fenske. All rights reserved.
// -------------------------------------------------------


import Foundation


struct GitHubAPI {

    private static let apiURL = NSURL(string: "https://api.github.com")


    private static func gitHubRequestWithURL(url: NSURL, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) {
        let sessionConfig = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        let dataTask = session.dataTaskWithURL(url, completionHandler: completionHandler)

        dataTask.resume()
    }


    private static func collectionFromJsonData(data: NSData) -> AnyObject? {
        do {
            return try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        }
        catch {
            return nil
        }
    }


    // MARK: - Public

    static func userForLogin(login: String, completionHandler: ([String: AnyObject]?) -> Void) {
        if let userURL = apiURL?.URLByAppendingPathComponent("users/\(login)") {
            gitHubRequestWithURL(userURL) { (responseData, urlResponse, error) -> Void in
                if let urlResponse = urlResponse as? NSHTTPURLResponse {
                    if urlResponse.statusCode == 200 {
                        let userDict = collectionFromJsonData(responseData!) as? [String: AnyObject]
                        completionHandler(userDict)
                        return
                    }
                }
                completionHandler(nil)
            }
        }
    }


    static func repositoriesForLogin(login: String, completionHandler: ([[String: AnyObject]]? -> Void)) {
        if let reposURL = apiURL?.URLByAppendingPathComponent("users/\(login)/repos") {
            gitHubRequestWithURL(reposURL) { (responseData, urlResponse, error) -> Void in
                if let urlResponse = urlResponse as? NSHTTPURLResponse {
                    if urlResponse.statusCode == 200 {
                        let reposArray = collectionFromJsonData(responseData!) as? [[String: AnyObject]]
                        completionHandler(reposArray)
                        return
                    }
                }
                completionHandler(nil)
            }
        }
    }
}

//
//  GitHubAPISearch.swift
//  GitHubClient
//
//  Created by Stefan Popp on 14.03.16.
//  Copyright © 2016 Stefan Mayer-Popp. All rights reserved.
//

import Foundation

class GitHubAPIEndpointSearch {
    
    /// Completion block which is called on repo list called
    typealias UsersListCompletion = ([User]?, NSError?) -> ()
    
    static func Users(forUsername username: String, completion: UsersListCompletion) -> GitHubAPIRequest {
        // Call repo api with username
        return GitHubAPI.request(endpoint: GitHubAPIEndpoint.Search.Users(username)).responseJSON { (response) -> Void in
            // Check result
            switch response.result {
            case .Failure(let error):
                completion(nil, error)
            case .Success(let result):
                // Map data with core data and return created objects
                completion(CoreDataMapper<User>.objects(fromArray: result["items"] as! [[String : AnyObject]]), nil)
            }
        }
    }
}
//
//  GitHubAPIUserController.swift
//  GitHubClient
//
//  Created by Stefan Popp on 12.03.16.
//  Copyright © 2016 Stefan Mayer-Popp. All rights reserved.
//

import UIKit

class GitHubAPIEndpointUser {
    /// Completion block which is called on repo list called
    typealias RepositoryListCompletion = ([Repository]?, NSError?) -> ()
    
    /**
     Returns a list of repositories for a given username
     
     - parameter username:   Name of the user
     - parameter completion: Completiton block which includes wrapped API call result
     */
    static func repositoryList(forUsername username: String, completion: RepositoryListCompletion) -> GitHubAPIRequest {
        // Call repo api with username
        return GitHubAPI.request(endpoint: GitHubAPIEndpoint.Users.Repos(username)).responseJSON { (response) -> Void in
            // Check result
            switch response.result {
            case .Failure(let error):
                completion(nil, error)
            case .Success(let result):
                // Map data with core data and return created objects
                completion(CoreDataMapper<Repository>.objects(fromArray: result as! [[String : AnyObject]]), nil)
            }
        }
    }
}


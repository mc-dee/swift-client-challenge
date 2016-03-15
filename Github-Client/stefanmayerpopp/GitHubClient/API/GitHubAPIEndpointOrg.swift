//
//  GitHubAPIOrg.swift
//  GitHubClient
//
//  Created by Stefan Popp on 13.03.16.
//  Copyright © 2016 Stefan Mayer-Popp. All rights reserved.
//

import Foundation
import UIKit

class GitHubAPIEndpointOrg {
    typealias RepositoryListCompletion = ([Repository]?, NSError?) -> ()

    /**
     Returns a list of repositories for a given organization name
     
     - parameter username:   Name of the organization
     - parameter completion: Completiton block which includes wrapped API call result
     */
    static func repositoryList(forOrganizationName orgName: String, completion: RepositoryListCompletion) -> GitHubAPIRequest {
        // Call repo api with organization name
        return GitHubAPI.request(endpoint: GitHubAPIEndpoint.Orgs.Repos(orgName)).responseJSON { (response) -> Void in
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

//
//  GitHubAPIUserController.swift
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
//  along with GitHubCLient.  If not, see <http://www.gnu.org/licenses/>.

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


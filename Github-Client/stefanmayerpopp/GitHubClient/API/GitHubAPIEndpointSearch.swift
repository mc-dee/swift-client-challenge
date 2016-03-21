//
//  GitHubAPISearch.swift
//  GitHubClient
//
//  Created by Stefan Popp on 14.03.16.
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
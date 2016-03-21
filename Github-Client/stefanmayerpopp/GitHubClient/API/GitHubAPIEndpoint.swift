//
//  GitHubEndpoint.swift
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

import Foundation

/**
 *  GitHub API Endpoint structure with enumerations of endpoints.
 *  They use associated values to bind arguments later in request builder.
 *  Not ultra smart in flexibility, but a nice showcase of associated values
 */
struct GitHubAPIEndpoint {
    
    // /orgs
    enum Orgs: GitHubEndPoint {
        typealias Organization =  String
        
        /**
         Returns repositories endpoints for repos
         
         - organization name
         */
        case Repos(Organization)
    }
    
    // /repos
    enum Repos: GitHubEndPoint {
        typealias Owner = String
        typealias Repo = String
        
        /**
         *  Returns repo details for given owner and repo
         *
         *  - Owner string
         *  - Repo  string
         */
        case Repos(Owner, Repo)
    }
    
    // /search 
    enum Search: GitHubEndPoint {
        typealias Username = String
        
        case Users(Username)
    }
    
    // /users
    enum Users: GitHubEndPoint {
        typealias Username = String
        
        /**
         Returns repositories endpoint for username
         
         - username
         */
        case Repos(Username)
    }
    
}

/**
 *  Endpoint must define a string variable which returns API description 
 *  for given case
 */
protocol GitHubEndPoint: CustomStringConvertible {
    var string: String { get }
}

/**
 *  Default implementation, in debug mode app crashes if implementation in
 *  child is missing
 */
extension GitHubEndPoint {
    // Returns the string reprenstation of API Endpoint from self.string in extensions
    var description: String { return self.string }

    // Ensure app crashes in debug mode
    var string: String {
        assert(false, "Implement me")
        return "Implement me"
    }
}

/**
 *  Organization endpoint
 */
extension GitHubAPIEndpoint.Orgs {
    var string: String {
        switch self {
        case .Repos(let organization):
            return "/orgs/\(organization)/repos"
        }
    }
}

/**
 *  Repos endpoint
 */
extension GitHubAPIEndpoint.Repos {
    var string: String {
        switch self {
        case Repos(let owner, let repo): // GET /repos/:owner/:repo
            return "/repos/\(owner)/\(repo)"
        }
    }
}

/**
 *  Search endpoint
 */
extension GitHubAPIEndpoint.Search {
    var string: String {
        switch self {
        case Users(let username): // GET /search/users?q=:username
            return "/search/users?q=\(username)"
        }
    }
}

/**
 *  Users endpoint
 */
extension GitHubAPIEndpoint.Users {
    var string: String {
        switch self {
        case .Repos(let username):
            return "/users/\(username)/repos"
        }
    }
}
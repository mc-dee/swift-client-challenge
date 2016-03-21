//
//  GitHubAPIResponse.swift
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

class GitHubAPIResponse<Result> {
    /// HTTP response of request
    let response: NSHTTPURLResponse?
    /// Original request
    let request: NSURLRequest?
    /// Raw data of request as NSData
    let data: NSData?
    /// Wrapped result object
    let result: GitHubAPIResult<AnyObject>

    /**
     Initialize a response
     
     - parameter response: Response of a request
     - parameter request:  Original request
     - parameter result:   Result wrapped object
     - parameter data:     Raw data of request as NSData
     
     - returns: GitHubAPIResponse object
     */
    init(
        response: NSHTTPURLResponse?,
        request: NSURLRequest?,
        result: GitHubAPIResult<AnyObject>,
        data: NSData?
        ) {
            self.response = response
            self.request = request
            self.data = data
            self.result = result
    }
}
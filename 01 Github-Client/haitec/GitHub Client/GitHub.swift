//
//  GitHub.swift
//  GitHub Client
//
//  Created by Miguel Dönicke on 13.03.16.
//  Copyright © 2016 Miguel Dönicke. All rights reserved.
//

import Foundation

class GitHub {

    enum Error : ErrorType {
        case NotFound
    }

    static let sharedInstance = GitHub()

    static let endpoint = "https://api.github.com"

    func getRepositories(fromUser username: String, completion: (json: [JSON]) -> Void) {
        // GET /users/:username/repos

        guard let url = NSURL(string: GitHub.endpoint.stringByAppendingString("/users/\(username)/repos")) else { return }
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            let json = Helper.parseJSON(fromData: data)
            ^{
                completion(json: json)
            }
        })
        task.resume()
    }

    func getReadme(forRepository repository: Repository, completion: (json: JSON) -> Void) {
        // GET /repos/:owner/:repo/readme

        guard let url = NSURL(string: GitHub.endpoint.stringByAppendingString("/repos/\(repository.full_name)/readme")) else { return }
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            let json = Helper.parseJSON(fromData: data)
            ^{
                completion(json: json.first!)
            }
        })
        task.resume()
    }

}
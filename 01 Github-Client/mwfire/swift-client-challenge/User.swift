//
//  User.swift
//  swift-client-challenge
//
//  Created by Martin Wildfeuer on 10.03.16.
//  Copyright © 2016 mwfire development. All rights reserved.
//

import Foundation

struct User {
    let id: Int
    let login: String
    let name: String?
    let avatarURL: String?
    let publicRepos: Int?
    
    init?(response: JSONDictionary?) {
        guard
            let response =  response,
            let id =        response["id"] as? Int,
            let login =     response["login"] as? String
            else {
                return nil
        }
        
        self.id = id
        self.login = login
        self.name = response["name"] as? String
        self.avatarURL = response["avatar_url"] as? String
        self.publicRepos = response["public_repos"] as? Int
    }
}
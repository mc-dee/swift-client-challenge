//
//  Repo.swift
//  swift-client-challenge
//
//  Created by Martin Wildfeuer on 21.03.16.
//  Copyright © 2016 mwfire development. All rights reserved.
//

import Foundation

struct Repo {
    let id: Int
    let name: String
    let description: String?
    let owner: User?
    
    init?(response: JSONDictionary?) {
        guard
            let response = response,
            let id       = response["id"] as? Int,
            let name     = response["name"] as? String,
            let owner    = response["owner"] as? JSONDictionary
            else {
                return nil
        }
        
        self.id = id
        self.name = name
        self.description = response["description"] as? String
        self.owner = User(response: owner)
    }
}
//
//  Repository.swift
//  GitHub Client
//
//  Created by Miguel Dönicke on 13.03.16.
//  Copyright © 2016 Miguel Dönicke. All rights reserved.
//

import Foundation

struct Repository {

    let name: String
    let full_name: String
    let description: String

    init?(fromJSON: JSON) throws {
        guard fromJSON["name"] as? String != nil else { throw GitHub.Error.NotFound }
        self.name = fromJSON["name"] as! String
        self.full_name = fromJSON["full_name"] as! String
        self.description = fromJSON["description"] as! String
    }

}
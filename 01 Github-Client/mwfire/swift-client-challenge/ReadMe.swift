//
//  ReadMe.swift
//  swift-client-challenge
//
//  Created by Martin Wildfeuer on 21.03.16.
//  Copyright © 2016 mwfire development. All rights reserved.
//

import Foundation

struct ReadMe {
    let url: String
    
    init?(response: JSONDictionary?) {
        guard
            let response = response,
            let url      = response["html_url"] as? String
            else {
                return nil
        }
        
        self.url = url
    }
}

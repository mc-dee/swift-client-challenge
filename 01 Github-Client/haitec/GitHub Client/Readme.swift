//
//  Readme.swift
//  GitHub Client
//
//  Created by Miguel Dönicke on 13.03.16.
//  Copyright © 2016 Miguel Dönicke. All rights reserved.
//

import Foundation

struct Readme {
    var content: String

    init?(fromJSON: JSON) throws {
        guard let content = fromJSON["content"] as? String else { throw GitHub.Error.NotFound }
        let data = NSData(base64EncodedString: content, options: .IgnoreUnknownCharacters)
        let encodedContent = String(data: data!, encoding: NSUTF8StringEncoding)
        self.content = encodedContent!
    }
}
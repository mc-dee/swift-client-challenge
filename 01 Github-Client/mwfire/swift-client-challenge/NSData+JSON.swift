//
//  File.swift
//  swift-client-challenge
//
//  Created by Martin Wildfeuer on 13.03.16.
//  Copyright © 2016 mwfire development. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

extension NSData {
    func toJSONDictionary() -> JSONDictionary? {
        return (try? NSJSONSerialization.JSONObjectWithData(self, options: [])) as? JSONDictionary
    }
    
    func toJSONArray() -> [AnyObject]? {
        return (try? NSJSONSerialization.JSONObjectWithData(self, options: [])) as? [AnyObject]
    }
}
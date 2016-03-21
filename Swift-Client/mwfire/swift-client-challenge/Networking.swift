//
//  File.swift
//  swift-client-challenge
//
//  Created by Martin Wildfeuer on 10.03.16.
//  Copyright © 2016 mwfire development. All rights reserved.
//

import Foundation

public struct Networking {
    
    private static let root = NSURL(string: "https://api.github.com/")!

    static func get(path: String, completion: (NSData?, NSError?) -> Void) {
        let url = NSURL(string: path, relativeToURL: root)!
        let request = NSMutableURLRequest()
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        request.URL = url
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(data, error)
            })
        }
        task.resume()
    }
}
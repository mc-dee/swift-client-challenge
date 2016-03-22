//
//  RepositoryModel.swift
//  github
//
//  Created by Alexander Elbracht on 15.03.16.
//  Copyright © 2016 Alexander Elbracht. All rights reserved.
//

import UIKit

class RepositoryModel: NSObject {
    var id: Int?
    var name: String?
    var desc: String?
    var readme: String?
    
    func parseReadme(user: String) {
        if let url = NSURL(string: "https://api.github.com/repos/\(user)/\(self.name!)/readme") {
            let session = NSURLSession(configuration: BasicAuth.sessionConfiguration())
            let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                do {
                    if let jsonContent = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                        
                        if let encodedString = jsonContent["content"] as? String {
                            let decodedData = NSData(base64EncodedString: encodedString, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
                            self.readme = String(data: decodedData!, encoding: NSUTF8StringEncoding)
                        }
                    }
                }
                catch let error as NSError {
                    print(error.localizedDescription)
                }
            })
            
            task.resume()
        }
    }
}

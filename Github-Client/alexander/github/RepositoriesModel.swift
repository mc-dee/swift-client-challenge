//
//  RepositoriesModel.swift
//  github
//
//  Created by Alexander Elbracht on 15.03.16.
//  Copyright © 2016 Alexander Elbracht. All rights reserved.
//

import UIKit

class RepositoriesModel: NSObject {
    var repositories = [RepositoryModel]()
    
    func parse(user: String, callback:() -> Void) {
        if let url = NSURL(string: "https://api.github.com/users/\(user)/repos") {            
            let session = NSURLSession(configuration: BasicAuth.sessionConfiguration())
            let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                do {
                    if let jsonRepositories = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray {
                        
                        self.repositories.removeAll()
                        
                        for jsonRepository in jsonRepositories {
                            let repository = RepositoryModel()
                            
                            if let id = jsonRepository["id"] as? Int {
                                repository.id = id
                            }
                            
                            if let name = jsonRepository["name"] as? String {
                                repository.name = name
                            }
                            
                            if let desc = jsonRepository["description"] as? String {
                                repository.desc = desc
                            }
                            
                            self.repositories.append(repository)
                        }
                    }
                    
                    callback()
                }
                catch let error as NSError {
                    print(error.localizedDescription)
                }
            })
        
            task.resume()
        }
    }
}

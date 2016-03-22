//
//  UsersModel.swift
//  github
//
//  Created by Alexander Elbracht on 13.03.16.
//  Copyright © 2016 Alexander Elbracht. All rights reserved.
//

import UIKit

class UsersModel: NSObject {
    var users = [UserModel]()
    
    func parse(query: String, callback:() -> Void) {
        if let url = NSURL(string: "https://api.github.com/search/users?q=\(query)") {
            let session = NSURLSession(configuration: BasicAuth.sessionConfiguration())
            let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                do {
                    if let jsonUsers = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                        
                        self.users.removeAll()
                        
                        for jsonUser in jsonUsers["items"] as! NSArray {
                            let user = UserModel()
                            
                            if let id = jsonUser["id"] as? Int {
                                user.id = id
                            }
                            
                            if let name = jsonUser["login"] as? String {
                                user.name = name
                            }
                            
                            if let avatarUrl = jsonUser["avatar_url"] as? String {
                                user.avatarUrl = avatarUrl
                            }
                            
                            self.users.append(user)
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

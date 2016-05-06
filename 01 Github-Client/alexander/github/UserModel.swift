//
//  UserModel.swift
//  github
//
//  Created by Alexander Elbracht on 15.03.16.
//  Copyright © 2016 Alexander Elbracht. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    var id: Int?
    var name: String?
    var avatarUrl: String?
    var avatar: UIImage?
    
    override init() {
        avatar = UIImage(named: "avatar")
    }
    
    func parseAvatar(callback:() -> Void) {
        if let avatarUrl = avatarUrl {
            if let url = NSURL(string: avatarUrl) {
                let session = NSURLSession.sharedSession()
                let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                    self.avatar = UIImage(data: data!)
                    callback()
                })
                
                task.resume()
            }
        }
    }
}

//
//  User.swift
//  Dasdom
//
//  Created by dasdom on 15.03.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import Foundation

struct User: LabelsPresentable, DictCreatable {
  let id: Int
  let name: String
  
  init?(dict: [NSObject : AnyObject]) {
    guard let theId = dict["id"] as? Int else { return nil }
    guard let theName = dict["login"] as? String else { return nil }
    
    id = theId
    name = theName
  }
  
  var texts: [String] { return [name] }
}
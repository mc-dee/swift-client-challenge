//
//  User.swift
//  Ben
//
//  Created by Benjamin Herzog on 10.03.16.
//  Copyright © 2016 Benjamin Herzog. All rights reserved.
//

import Foundation
import Network
import Mapper
import TableViewListModel

struct User: Mappable, Identifiable {
	
	var id = 0
	var userName = ""
	var name = ""
	var avatatUrl = ""
	
	var company = ""
	var biography = ""
	var town = ""
	
	var reposPublic = 0
	var followers = 0
	var following = 0
	
	init?(_ json: JSON) {
		id ~~ json["id"]
		userName ~~ json["login"]
		name ~~ json["name"]
		avatatUrl ~~ json["avatar_url"]
		
		company ~~ json["company"]
		biography ~~ json["bio"]
		town ~~ json["location"]
		
		reposPublic ~~ json["public_repos"]
		followers ~~ json["followers"]
		following ~~ json["following"]
		
		if userName.isEmpty {
			return nil
		}
	}
}

struct UserEndpint: Endpoint {
	
	typealias ObjectType = User
	
	var userName: String
	
	var path: String {
		return "users/\(userName)"
	}
}

struct UserViewModel: ViewModelType {
	
	var user: User
	
	init(model: User) {
		user = model
	}
}

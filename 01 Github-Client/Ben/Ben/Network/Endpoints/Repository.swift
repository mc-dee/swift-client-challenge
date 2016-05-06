//
//  Endpoints.swift
//  Ben
//
//  Created by Benjamin Herzog on 10.03.16.
//  Copyright © 2016 Benjamin Herzog. All rights reserved.
//

import Foundation
import Mapper
import Network
import TableViewListModel

struct Repository: Mappable, Identifiable {
	
	var id = 0
	
	var owner: User?
	
	var desc = ""
	
	var forks = 0
	var stars = 0
	var watchers = 0
	
	var url = ""
	var name = ""
	var fullName = ""
	var language = ""
	
	init?(_ json: JSON) {
		id ~~ json["id"]
		
		owner ~~ json["owner"]
		
		desc ~~ json["description"]
		
		forks ~~ json["forks"]
		stars ~~ json["stargazers_count"]
		watchers ~~ json["watchers"]
		
		url ~~ json["url"]
		name ~~ json["name"]
		fullName ~~ json["full_name"]
		language ~~ json["language"]
		
		if fullName.isEmpty || name.isEmpty {
			return nil
		}
	}
}

struct RepositoriesEndpoint: Endpoint {
	
	typealias ObjectType = Repository
	
	var user: User
	
	var urlParameter: [String: String]? {
		return ["per_page": 1000.description]
	}
	
	var path: String {
		return "users/\(user.userName)/repos"
	}
}

struct RepoViewModel: ViewModelType {
	
	private(set) var repo: Repository
	
	var detailsString: String {
		return "⭐️: \(repo.stars) - \(repo.desc)"
	}
	
	init(model: Repository) {
		repo = model
	}
}

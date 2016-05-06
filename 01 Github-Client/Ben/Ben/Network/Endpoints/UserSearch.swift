//
//  UseSearch.swift
//  Ben
//
//  Created by Benjamin Herzog on 11/03/16.
//  Copyright © 2016 Benjamin Herzog. All rights reserved.
//

import Mapper
import Network
import Helper

struct UserSearchResponse: Mappable {
	
	var items = [User]()
	
	init?(_ json: JSON) {
		
		items ~~ json["items"]
	}
}

struct UserSearchEndpoint: Endpoint {
	
	typealias ObjectType = UserSearchResponse
	
	var searchTerm: String
	
	var urlParameter: [String: String]? {
		return ["q": searchTerm.htmlQuery]
	}
	
	var path: String {
		return "search/users"
	}
}

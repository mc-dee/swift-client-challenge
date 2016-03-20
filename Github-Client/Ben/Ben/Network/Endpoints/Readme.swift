//
//  Readme.swift
//  Ben
//
//  Created by Benjamin Herzog on 10.03.16.
//  Copyright © 2016 Benjamin Herzog. All rights reserved.
//

import Foundation
import Mapper
import Network
import TableViewListModel

struct Readme: Mappable, Identifiable {
	
	var name = ""
	var url = ""
	var rawUrl = ""
	
	var urlRequest: NSURLRequest? {
		return NSURL(string: url).map { NSURLRequest(URL: $0) }
	}
	
	init?(_ json: JSON) {
		name ~~ json["name"]
		url ~~ json["html_url"]
		rawUrl ~~ json["download_url"]
		
		if name.isEmpty {
			return nil
		}
	}
}

struct ReadmeEndpint: Endpoint {
	
	typealias ObjectType = Readme
	
	var repo: Repository
	
	var path: String {
		return "repos/\(repo.fullName)/readme"
	}
}

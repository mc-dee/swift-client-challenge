//
//  Rest.swift
//  Ben
//
//  Created by Benjamin Herzog on 10.03.16.
//  Copyright © 2016 Benjamin Herzog. All rights reserved.
//

import Foundation
import Network

class Rest: RequestPool {
	
	static var shared = Rest()
	
	private let baseUrl = "https://api.github.com/"
	
	private init() {
		super.init(baseURL: baseUrl)
		
		maxConcurrentOperationCount = 3
	}
}

extension Request {
	
	func fire() {
		Rest.shared.addRequest(self)
	}
}

//
//  ReadmeMVC.swift
//  Ben
//
//  Created by Benjamin Herzog on 11/03/16.
//  Copyright © 2016 Benjamin Herzog. All rights reserved.
//

import UIKit

class ReadmeController: Controller {
	
	let webView = UIWebView()
	
	var repo: Repository?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		webView.frame = view.bounds
		webView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
		view.addSubview(webView)
		
		guard let repo = repo else {
			self.noReadme()
			return
		}
		
		title = repo.fullName
		
		ReadmeEndpint(repo: repo).request {
			[weak self] response in
			
			guard let readme = response.object,
				request = readme.urlRequest else {
					self?.noReadme()
					return
			}
			
			self?.webView.loadRequest(request)
			}.fire()
	}
	
	private func noReadme() {
		self.webView.loadHTMLString("<center><h1>No README</h1></center>", baseURL: nil)
	}
}

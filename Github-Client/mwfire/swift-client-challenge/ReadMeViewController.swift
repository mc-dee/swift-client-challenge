//
//  ReadMeViewController.swift
//  swift-client-challenge
//
//  Created by Martin Wildfeuer on 21.03.16.
//  Copyright © 2016 mwfire development. All rights reserved.
//

import UIKit

class ReadMeViewController: UIViewController, Routable {

    var routeRequest: RouteRequest?
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let routeRequest = routeRequest else { return }
        title = routeRequest.options[":repo"]
        
        Networking.get(routeRequest.path) { (data, error) -> Void in
            guard let data = data, response = data.toJSONDictionary() else { return }
            
            if let readMe = ReadMe(response: response) {
                let url = NSURL(string: readMe.url), request = NSURLRequest(URL: url!)
                self.webView.loadRequest(request)
            }
        }
    }
}

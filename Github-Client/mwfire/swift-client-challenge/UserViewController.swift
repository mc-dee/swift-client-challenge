//
//  UserViewController.swift
//  swift-client-challenge
//
//  Created by Martin Wildfeuer on 21.03.16.
//  Copyright © 2016 mwfire development. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, Routable {
    
    var routeRequest: RouteRequest?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var repoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let routeRequest = routeRequest else { return }
        title = routeRequest.options[":username"]
        
        Networking.get(routeRequest.path) { (data, error) -> Void in
            guard let data = data, user = User(response: data.toJSONDictionary()) else { return }
            self.nameLabel.text = user.name
            if let publicRepos = user.publicRepos {
                self.repoLabel.text = "Public Repositories: \(publicRepos)"
            }
        }
    }
    
    @IBAction func didTouchUpInside(sender: UIButton) {
        guard let routeRequest = routeRequest else { return }
        Navigator.sharedNavigator.push("users/\(routeRequest.options[":username"]!)/repos")
    }
}

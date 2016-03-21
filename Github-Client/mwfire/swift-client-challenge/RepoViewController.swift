//
//  RepoViewController.swift
//  swift-client-challenge
//
//  Created by Martin Wildfeuer on 21.03.16.
//  Copyright © 2016 mwfire development. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController, Routable {

    var routeRequest: RouteRequest?
    var dataProvider: RepoDataProvider?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let routeRequest = routeRequest else { return }
        title = routeRequest.options[":username"]
        
        // Init data provider and load data
        dataProvider = RepoDataProvider(routeRequest: routeRequest)
        dataProvider?.tableView = tableView
        dataProvider?.loadData()
    }
}

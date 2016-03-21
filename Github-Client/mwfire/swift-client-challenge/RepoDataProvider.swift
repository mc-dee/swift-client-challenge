//
//  RepoDataProvider.swift
//  swift-client-challenge
//
//  Created by Martin Wildfeuer on 21.03.16.
//  Copyright © 2016 mwfire development. All rights reserved.
//

import Foundation
import UIKit

class RepoDataProvider : NSObject {
    
    let routeRequest: RouteRequest
    
    weak var tableView: UITableView? {
        didSet {
            tableView?.dataSource = self
            tableView?.delegate = self
        }
    }
    
    private var dataSource = [Repo]()
    
    init(routeRequest: RouteRequest) {
        self.routeRequest = routeRequest
        super.init()
    }
    
    func loadData() {
        Networking.get(routeRequest.path) { (data, error) in
            guard let data = data, json = data.toJSONArray() else {
                return
            }
            self.dataSource = json.map { Repo(response: $0 as? JSONDictionary)! }
            self.tableView?.reloadData()
        }
    }
}

extension RepoDataProvider: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseIdentifier = "repoCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier)
        cell = cell ?? UITableViewCell(style: .Subtitle, reuseIdentifier: reuseIdentifier)
        cell!.textLabel!.text = dataSource[indexPath.row].name
        cell!.detailTextLabel!.text = dataSource[indexPath.row].description ?? ""
        cell!.detailTextLabel!.textColor = UIColor.lightGrayColor()
        return cell!
    }
}

extension RepoDataProvider: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let repo = dataSource[indexPath.row]
        let path = "repos/\(routeRequest.options[":username"]!)/\(repo.name)/readme"
        Navigator.sharedNavigator.push(path)
    }
}
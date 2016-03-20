// -------------------------------------------------------
//  ReposViewController.swift
//  GitHubClientChallenge
//
//  Created by Michael on 11.03.2016.
//  Copyright © 2016 Michael Fenske. All rights reserved.
// -------------------------------------------------------


import UIKit


class ReposViewController : UITableViewController {

    var dataSource: PlainTableDataSource<UITableViewCell, GitHubRepository>!
    var gitHubUser: GitHubUser! {
        didSet {
            dataSource = PlainTableDataSource(items: gitHubUser.repos, cellIdentifier: "RepositoryCell") { (cell, item) -> Void in
                cell.textLabel?.text = item.name
            }
        }
    }


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.title = "\(gitHubUser.name) (\(gitHubUser.login))"
        tableView.dataSource = dataSource
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let detailController = segue.destinationViewController as? RepoDetailViewController
            detailController?.repository = dataSource.itemAtIndexPath(indexPath)
        }
    }
}

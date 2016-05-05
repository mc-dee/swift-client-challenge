//
//  RepositoryTableViewController.swift
//  GitHub Client
//
//  Created by Miguel Dönicke on 12.03.16.
//  Copyright © 2016 Miguel Dönicke. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    let cellIdentifier = "repositoryCell"
    let segueIdentifier = "showDetail"
    var repositories = [Repository]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? UITableViewCell {
            if let index = self.tableView.indexPathForCell(cell)?.row {
                if segue.identifier == self.segueIdentifier {
                    let viewController = segue.destinationViewController as! DetailViewController
                    viewController.repository = self.repositories[index]
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                    GitHub.sharedInstance.getReadme(forRepository: self.repositories[index]) { json in
                        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                        guard let readme = try? Readme(fromJSON: json) else { return }
                        viewController.readme = readme
                    }
                }
            }
        }
    }

}

// MARK: - UITableViewDataSource

extension SearchViewController : UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositories.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) ?? UITableViewCell()
        cell.textLabel?.text = self.repositories[indexPath.row].name
        return cell
    }

}

// MARK: - UISearchBarDelegate

extension SearchViewController : UISearchBarDelegate {

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let username = searchBar.text {
            let user = username.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            if !user.isEmpty {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                GitHub.sharedInstance.getRepositories(fromUser: user) { json in
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    var repos = [Repository]()
                    for jsonRepo in json {
                        guard let repo = try? Repository(fromJSON: jsonRepo) else {
                            Helper.showAlert("Error", withMessage: String("Not found"), inViewController: self)
                            return
                        }
                        repos.append(repo!)
                    }
                    self.repositories = repos
                }
                searchBar.resignFirstResponder()
            } else {
                Helper.showAlert("Error", withMessage: "Username is empty", inViewController: self)
            }
        }
    }

}

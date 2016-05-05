//
//  RepositoriesTableViewController.swift
//  github
//
//  Created by Alexander Elbracht on 15.03.16.
//  Copyright © 2016 Alexander Elbracht. All rights reserved.
//

import UIKit

class RepositoriesTableViewController: UITableViewController {

    var user: String?
    var repositories: RepositoriesModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repositories = RepositoriesModel()
        if let user = user {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            repositories!.parse(user, callback: { () -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                    
                    for repository in self.repositories!.repositories {
                        repository.parseReadme(user)
                    }
                    
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let repositories = repositories {
            return repositories.repositories.count
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        
        if let repositories = repositories {
            cell.textLabel?.text = repositories.repositories[indexPath.row].name
            cell.detailTextLabel?.text = repositories.repositories[indexPath.row].desc
        }
        
        return cell;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            if let row = indexPath?.row {
                if let repository = repositories?.repositories[row] {
                    (segue.destinationViewController as! DetailViewController).name = repository.name
                    (segue.destinationViewController as! DetailViewController).desc = repository.desc
                    (segue.destinationViewController as! DetailViewController).readme = repository.readme
                }
            }
        }
    }
}

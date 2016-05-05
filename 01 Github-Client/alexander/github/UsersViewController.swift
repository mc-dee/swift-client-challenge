//
//  ViewController.swift
//  github
//
//  Created by Alexander Elbracht on 13.03.16.
//  Copyright © 2016 Alexander Elbracht. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTableView: UITableView!

    var users: UsersModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTextField.delegate = self
        
        users = UsersModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let query = textField.text {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            users!.parse(query, callback: { () -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    self.searchTableView.reloadData()
                    
                    for user in self.users!.users {
                        user.parseAvatar({ () -> Void in
                            dispatch_async(dispatch_get_main_queue()) {
                                self.searchTableView.reloadData()
                            }
                        })
                    }
                    
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
            })
        }
        
        searchTextField.endEditing(true)
        
        return true
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let users = users {
            return users.users.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCellWithIdentifier("Cell")! as! UsersTableViewCell
        
        if let users = users {
            cell.userImageView.image = users.users[indexPath.row].avatar
            cell.userLabel.text = users.users[indexPath.row].name
        }
        
        return cell;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "repositoriesSegue" {
            let indexPath = searchTableView.indexPathForCell(sender as! UsersTableViewCell)
            if let row = indexPath?.row {
                if let user = users?.users[row] {
                    (segue.destinationViewController as! RepositoriesTableViewController).user = user.name
                }
            }
        }
    }
}


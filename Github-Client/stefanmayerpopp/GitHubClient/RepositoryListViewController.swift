//
//  RepositoryListViewController.swift
//  GitHubClient
//
//  Created by Stefan Popp on 13.03.16.
//  Copyright © 2016 Stefan Mayer-Popp. All rights reserved.
//

import UIKit

class RepositoryListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var switchSourcesOnly: UISwitch!
    
    /// Name of the user or org
    var username: String!
    
    /// Unfiltered repositories is used as internal variable, so we can filter easily
    private var _unfilteredRepositories: [Repository]?
    /** 
     Public repositories variable which stores its data in _unfilteredRepositories
     and returns filtered array if sources only switch is on
    */
    var repositories: [Repository]? {
        get {
            if switchSourcesOnly.on {
                // Return repositories which are owned by given user/organisation
                return self._unfilteredRepositories?.filter { $0.fork?.boolValue == false }
            }
            return self._unfilteredRepositories
        }
        set {
            self._unfilteredRepositories = newValue
        }
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        // Make the sources switch a bit smaller
        switchSourcesOnly.transform = CGAffineTransformMakeScale(0.75, 0.75)
        switchSourcesOnly.updateConstraintsIfNeeded()
        switchSourcesOnly.layoutIfNeeded()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    
    
    // MARK: View presentation styles
    /**
     Set light content for status bar
     
     - returns: UIStatusBarStyle for light content
     */
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: UITableViewDataSource
    /**
    Number of rows for given table
    
    - parameter tableView: Table view who is asking for
    - parameter section:   Section of table view
    
    - returns: Number of rows for given table view and section
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let repositories = repositories else { return 0 }
        return repositories.count
    }
    
    /**
     Returns a configured base cell
     
     - parameter tableView: tableView whos is asking for cell
     - parameter indexPath: indexPath of cell
     
     - returns: configured cepository cell
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("repoCell", forIndexPath: indexPath) as! RepositoryCell
        cell.configure(forRepository: repositories![indexPath.row])
        return cell
    }
    
    // MARK: User actions
    /**
    Send user back to previous view controller
    
    - parameter sender: Hopefully a button
    */
    @IBAction func backButtonTouched(sender: UIButton) {
        // TODO: Flash databae?
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    /**
     Called when source filter switch is touched
     
     - parameter sender: UISwitch
     */
    @IBAction func sourceOnlySwitchTouched(sender: UISwitch) {
            self.tableView.reloadData()
    }
}



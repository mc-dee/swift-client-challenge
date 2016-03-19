//
//  TableViewController.swift
//  Challenge_Daniel_Piotrowski
//
//  Created by Daniel Piotrowski on 11.03.16.
//  Copyright © 2016 MeDaPi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    var items = [[String:AnyObject]]()
    static var user1: String = ""
    
    var user2: String = user1
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
 
        
        
        
    }
    
    
    
    func loadData() {
        self.navigationItem.title  = "\(user2) repo"
        
        let url = NSURL(string: "https://api.github.com/users/\(user2)/repos")!
        let urlSession = NSURLSession.sharedSession()
        
        let task = urlSession.dataTaskWithURL(url) { (data, response, error) in
            
            self.items = try! NSJSONSerialization.JSONObjectWithData(data!,
                options: NSJSONReadingOptions()) as! [[String:AnyObject]]
            
            NSOperationQueue.mainQueue().addOperationWithBlock {
                self.tableView.reloadData()
                self.animateTableViewCells()
            }
            
        }
        
        task.resume()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return items.count
    //    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let item = items[indexPath.row]
        
        if item["name"] as? String == "" {
            cell.textLabel?.text = "Hier ist nichts, oder vielleicht doch?"
        } else {
            cell.textLabel?.text = item["name"] as? String
        }
        
        
        print(items.count)
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        let item = items[indexPath.row]
        
        DetailVC.currentRepo = item["html_url"] as! String
        DetailVC.navigationItemTitle = item["name"] as! String
        
        self.performSegueWithIdentifier("test", sender: self)
    }

    
    override func viewWillAppear(animated: Bool) {
        
        animateTableViewCells()
        
    }
    
    
    func animateTableViewCells() {
        
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        
        let height: CGFloat = tableView.bounds.size.height
        
        for initialCell in cells {
            
            let cell: UITableViewCell = initialCell
            
            cell.transform = CGAffineTransformMakeTranslation(5, height)
            
        }
        
        var indexOfCell = 0
        
        for finalCell in cells {
            
            let cell: UITableViewCell = finalCell
            
            UIView.animateWithDuration(1.0,
                delay: 0.05 * Double(indexOfCell),
                usingSpringWithDamping: 0.75,
                initialSpringVelocity: 0,
                options: [],
                animations: {
                    cell.transform = CGAffineTransformMakeTranslation(5, 5);
                }, completion: nil)
            
            indexOfCell += 1
        }
        
    }
    

    
    

    

    
    
}

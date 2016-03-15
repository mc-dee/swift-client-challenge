//
//  AccountSelectionViewController+SuggestionTableViewExtension.swift
//  GitHubClient
//
//  Created by Stefan Popp on 14.03.16.
//  Copyright © 2016 Stefan Mayer-Popp. All rights reserved.
//

import UIKit

// MARK: - Provides suggestion table base on user
extension AccountSelectionViewController : UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Suggestion table view
    /**
     Shows a suggestion table view if some users are returned by GitHub API
     
     - parameter users: An array of User
     */
    func showSuggestionTableView(forUsers users: [User]?) {
        // Set user array
        userSuggestions = users?.sort { $0.0.login < $0.1.login }
        
        // Reload data
        tblViewUserSearch.reloadData()

        // Hide or show tableView
        guard let users = users where users.count > 0 else {
            shouldShowUserSuggestionTableView(show: false)
            return
        }
        
        // Show table view
        shouldShowUserSuggestionTableView(show: true)
    }
    
    func shouldShowUserSuggestionTableView(show show: Bool, animated: Bool = true) {
        CstrTblViewHeight.constant = (show) ? usersSearchSuggestTableViewHeight() : 0
        let updateBlock =  {
            self.view.updateConstraintsIfNeeded()
            self.view.layoutIfNeeded()
        }
        
        if !animated {
            return updateBlock()
        }
        
        UIView.animateWithDuration(0.2, animations: updateBlock)
    }
    
    // MARK: Delegation
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userSuggestions?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Get table view cell for user search
        let cell = tableView.dequeueReusableCellWithIdentifier("usersSearchResultCell", forIndexPath: indexPath) as! UsersSearchResultCell
        
        // get user from suggestions array
        guard let user = userSuggestions?[indexPath.row] else {
            return cell
        }
        
        // Configure cell with user object
        cell.configure(forUser: user)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        defer {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
        // get user from suggestions array
        guard let user = userSuggestions?[indexPath.row] else { return }
        
        // get login name
        guard let login = user.login else { return }
        
        // get repositories
        showRepositories(forUsername: login)
    }
    
    /**
     Called when someone types something into the user textfield
     
     - parameter textField: textfield which is been edited
     - parameter range:     unsed range of change
     - parameter string:    unsused string of change
     
     - returns: true, we always allow editing of the textfield
     */
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // Ignore empty field
        guard isTextFieldFulfilled(textField) else {
            // Hide table view
            return true
        }
        
        // Seach users for name
        searchUsers(forUsername: txtFieldUsername.text!)
        
        return true
    }
    
    /**
     Searches the userdatabase from github for given username
     
     - parameter username: username which should be searched
     */
    func searchUsers(forUsername username: String) {
        // Cancel current task if present
        userSearchRequest?.cancel()
        
        // Search and present user suggestion
        userSearchRequest = GitHubAPIEndpointSearch.Users(forUsername: username) { (users, error) -> () in
            if error == nil {
                // segue with repositories
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.showSuggestionTableView(forUsers: users)
                })
                return
            }
        }
    }
    
    /**
     Remove suggestions table view if textfield is cleared
     
     - parameter textField: textfield which has been cleared
     
     - returns: True, so textField can be cleared
     */
    func textFieldShouldClear(textField: UITextField) -> Bool {
        // Clear users array
        userSuggestions = nil
        
        // Remove suggestion
        shouldShowUserSuggestionTableView(show: false)
        return true
    }
}
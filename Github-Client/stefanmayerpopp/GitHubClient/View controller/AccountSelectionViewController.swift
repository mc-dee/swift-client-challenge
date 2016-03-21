//
//  ViewController.swift
//  GitHubClient
//
//  Created by Stefan Popp on 12.03.16.
//  Copyright © 2016 Stefan Mayer-Popp. All rights reserved.
//

import UIKit

class AccountSelectionViewController: UIViewController, UITextFieldDelegate {

    // MARK: Outlets
    @IBOutlet weak var txtFieldUsername: LoginTextField!
    @IBOutlet weak var btnShowRepositories: SearchButton!
    @IBOutlet weak var tblViewUserSearch: UITableView!
    @IBOutlet weak var CstrTblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imgViewGitHubLogo: UIImageView!
    
    // MARK: Variables and constants
    var userSuggestions: [User]?
    var userSearchRequest: GitHubAPIRequest?
    
    // MARK: Constraint original values
    var _cstrTblViewHeightConstant = CGFloat(0)
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Save constraint constant for suggestion table view height
        _cstrTblViewHeightConstant = CstrTblViewHeight.constant
        
        // Remove single spacer from empty cells
        tblViewUserSearch.tableFooterView = UIView(frame: CGRectZero)
        
        // Hide suggestion table view
        shouldShowUserSuggestionTableView(show: false, animated: false)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        
        // If view is reentered from a detail view, we reenable the show button
        btnShowRepositories.setButton(enabled: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        applyRippleEffect(onImageView: imgViewGitHubLogo)
    }
    
    // MARK: Repository and API
    /**
    Show and load data for a specified user/organization name
    
    - parameter forUsername: user or organization name
    */
    func showRepositories(forUsername username: String) {
        btnShowRepositories.setButton(enabled: false)
        
        // Set username to login text field
        txtFieldUsername.text = username
        
        // Get repoistories for users and organistions
        GitHubAPIEndpointUser.repositoryList(forUsername: username) { (repositories, error) -> Void in
            // If we have an error, we try to get repo list for orgs, otherwise we show the error
            if error == nil {
                // segue with repositories
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.performSegueWithIdentifier("repoList", sender: repositories)
                })
                return
            }
            
            // Fetch organization repository list
            GitHubAPIEndpointOrg.repositoryList(forOrganizationName: username, completion: { (repositories, error) -> () in
                if error == nil {
                    // segue with repositories
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.performSegueWithIdentifier("repoList", sender: repositories)
                    })
                    return
                }
                
                // Show an error because we have nothing to show at all =/
                let alertController = UIAlertController(
                    title: "Ups!",
                    message: "Kein Repos gefunden :/\n\(error!.localizedDescription)",
                    preferredStyle: .Alert
                )
                
                dispatch_async(dispatch_get_main_queue()) {
                    alertController.addAction(UIAlertAction(title: "😢", style: .Default, handler: nil))
                    self.presentViewController(alertController, animated: true, completion: {
                        self.btnShowRepositories.setButton(enabled: true)
                    })
                }
            })
        }
    }

    /**
     Set light content for status bar
     
     - returns: UIStatusBarStyle for light content
     */
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: Text field utilities
    /**
    Check if a given text field has text lenght > 0
    
    In this sample app the validation is hardcoded. Sorry 😢!
    
    - parameter textField: a textfield which must have length > 0
    
    - returns: true if dependency is fulfilled
    */
    func isTextFieldFulfilled(textField: UITextField, shouldShowError showError: Bool = true) -> Bool {
        
        // Everything fine if characters count > 0
        if textField.text?.characters.count >= 0 {
            return true
        }
        
        // If error should be shown, we present one on current view controller
        if showError {
            let alertController = UIAlertController(
                title: "Ups!",
                message: "Bitte gib einen Benutzer oder Organisationsnamen an!",
                preferredStyle: .Alert
            )
            alertController.addAction(UIAlertAction(title: "😓", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        return false
    }

    // MARK: Interface actions
    /**
    Called if user touches the show repositories button
    
    - parameter sender: Button user touched
    */
    @IBAction func showRepositoriesTouched(sender: UIButton) {
        // Did user entered username?
        guard isTextFieldFulfilled(txtFieldUsername) else { return }

        // Dismiss keyboard
        self.view.endEditing(true)
        
        showRepositories(forUsername: txtFieldUsername.text!)
    }
    
    /**
     Closes keyboard if someone touches the background image
     
     - parameter sender: tap recognizer
     */
    @IBAction func imageViewTapped(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "repoList" {
            let destinationViewController = segue.destinationViewController as? RepositoryListViewController
            destinationViewController?.repositories = sender as? [Repository]
            destinationViewController?.username = txtFieldUsername.text
            return
        }
    }
    
    // MARK: Text field delegation
    /**
    Called if user touches the search button in the keyboard
    
    - parameter textField: textField the keyboard is attached too
    
    - returns: Prevents dimiss of keyboard if required textfield is not fulfilled
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        guard isTextFieldFulfilled(textField) else {
            return false
        }
        
        searchUsers(forUsername: txtFieldUsername.text!)
        return true
    }
    
    /**
     Returns the maximum height for the drawable content size of the user
     suggest table view
     
     - returns: height for table view
     */
    func usersSearchSuggestTableViewHeight() -> CGFloat {
        // Default cell height
        let cellHeight = 30.0
        
        // Estimate visible rows per display height
        let height = self.view.frame.height
        switch height {
        case height where height <= 500:
            return CGFloat(2.2*cellHeight)
        case height where height <= 600:
            return CGFloat(5*cellHeight)
        case height where height <= 700:
            return CGFloat(8*cellHeight)
        case height where height <= 750:
            return CGFloat(10*cellHeight)
        default:
            break
        }
        // I was so close for fibonacci 2,3,5,8,11 =/
        return CGFloat(4*cellHeight)
    }
}


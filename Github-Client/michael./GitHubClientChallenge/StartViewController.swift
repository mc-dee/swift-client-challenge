// ---------------------------------------------------
//  StartViewController.swift
//  GitHubClientChallenge
//
//  Created by Michael on 11.03.2016.
//  Copyright © 2016 Michael Fenske. See LICENSE.txt.
// ---------------------------------------------------


import UIKit


class StartViewController : UIViewController, UITextFieldDelegate {

    private var gitHubUser: GitHubUser? {
        didSet {
            activityIndicatorView.stopAnimating()
            if gitHubUser != nil {
                performSegueWithIdentifier("StartToRepos", sender: self)
            }
            else {
                showUserAlert()
            }
        }
    }

    private var login: String = ""
    private var name: String = ""

    private func showUserAlert() {
        let alertController = UIAlertController(title: "User not found", message: nil, preferredStyle: .Alert)

        alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }


    private func fetchRepositories() {
        GitHubAPI.repositoriesForLogin(login) { (reposArray) -> Void in
            if let reposArray = reposArray {
                let repositories = reposArray.map { (repository) -> GitHubRepository in
                    let name = repository["name"] as? String ?? ""
                    let description = repository["description"] as? String ?? ""
                    return GitHubRepository(name: name, description: description)
                }
                self.gitHubUser = GitHubUser(login: self.login, name: self.name, repos: repositories)
            }
        }
    }


    // MARK: - Public

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var userNameField: UITextField!

    @IBAction func showRepositories(sender: UIButton) {
        userNameField.resignFirstResponder()
        activityIndicatorView.startAnimating()

        if let login = userNameField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) {
            GitHubAPI.userForLogin(login) { (userDict) -> Void in
                if let userDict = userDict {
                    self.login = userDict["login"] as? String ?? ""
                    self.name = userDict["name"] as? String ?? ""

                    if !self.login.isEmpty {
                        self.fetchRepositories()
                        return
                    }
                }
                self.gitHubUser = nil
            }
        }
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let reposController = segue.destinationViewController as? ReposViewController
        reposController?.gitHubUser = gitHubUser
    }


    // MARK: - TextFieldDelegate

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

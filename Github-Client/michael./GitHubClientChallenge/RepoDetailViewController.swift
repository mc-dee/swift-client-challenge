// -------------------------------------------------------
//  RepoDetailViewController.swift
//  GitHubClientChallenge
//
//  Created by Michael on 19.03.2016.
//  Copyright © 2016 Michael Fenske. All rights reserved.
// -------------------------------------------------------


import UIKit


class RepoDetailViewController : UIViewController {

    @IBOutlet var descriptionTextView: UITextView!
    var repository: GitHubRepository!


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.title = repository.name
        descriptionTextView.text = repository.description
    }
}

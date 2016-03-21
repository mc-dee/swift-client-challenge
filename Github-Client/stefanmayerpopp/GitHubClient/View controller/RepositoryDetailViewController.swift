//
//  RepositoryDetailViewController.swift
//  GitHubClient
//
//  Created by Stefan Popp on 14.03.16.
//  Copyright © 2016 Stefan Mayer-Popp. All rights reserved.
//

import UIKit

class RepositoryDetailViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var lblRepositoryName: UILabel!
    @IBOutlet weak var txtViewRepositoryDescription: UITextView!
    
    // MARK: Variables
    var repository: Repository!

    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    // MARK: View configuration and utilities
    func configureView() {
        lblRepositoryName.text = repository.name
        txtViewRepositoryDescription.text = repository.description_val
        if txtViewRepositoryDescription.text.characters.count == 0 {
            txtViewRepositoryDescription.text = "😕 Keine Beschreibung für \(repository.name ?? "") vorhanden"
        }
    }

    /**
     Called when back button is touched
     
     - parameter sender: UIButton which has been touched
     */
    @IBAction func backButtonTouched(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    /**
     Set light content for status bar
     
     - returns: UIStatusBarStyle for light content
     */
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

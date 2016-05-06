//
//  RepositoryDetailViewController.swift
//  GitHubClient
//
//  Created by Stefan Popp on 14.03.16.
//
//  This file is part of GitHubCLient.
//
//  GitHubCLient is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  GitHubCLient is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with GitHubCLient.  If not, see <http://www.gnu.org/licenses/>.

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

//
//  RootViewController.swift
//  swift-client-challenge
//
//  Created by Martin Wildfeuer on 21.03.16.
//  Copyright © 2016 mwfire development. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select User"
    }

    @IBAction func didTouchUpInside(sender: UIButton) {
        guard let userName = textField.text else {
            return
        }
        
        if !userName.isEmpty {
            Navigator.sharedNavigator.push("users/\(userName)")
        }
    }
}

//
//  DetailViewController.swift
//  GitHub Client
//
//  Created by Miguel Dönicke on 12.03.16.
//  Copyright © 2016 Miguel Dönicke. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var repository: Repository! {
        didSet {
            ^{
                self.title = self.repository.name
                self.descriptionLabel.text = self.repository.description
            }
        }
    }
    var readme: Readme! {
        didSet {
            ^{
                self.textView.text = self.readme.content
            }
        }
    }

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = ""
        self.descriptionLabel.text = ""
        self.textView.text = ""
    }
}

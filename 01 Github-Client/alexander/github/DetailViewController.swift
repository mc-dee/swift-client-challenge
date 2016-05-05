//
//  DetailViewController.swift
//  github
//
//  Created by Alexander Elbracht on 15.03.16.
//  Copyright © 2016 Alexander Elbracht. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var readmeTextView: UITextView!

    var name: String?
    var desc: String?
    var readme: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = name
        descriptionLabel.text = desc
        readmeTextView.text = readme
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

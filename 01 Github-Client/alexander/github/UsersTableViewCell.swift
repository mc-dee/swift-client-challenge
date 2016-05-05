//
//  UsersTableViewCell.swift
//  github
//
//  Created by Alexander Elbracht on 13.03.16.
//  Copyright © 2016 Alexander Elbracht. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageView.layer.borderWidth = 0.5
        userImageView.layer.borderColor = UIColor(red:0.7, green:0.7, blue:0.7, alpha:1).CGColor
        userImageView.layer.cornerRadius = userImageView.frame.height/2
        userImageView.layer.masksToBounds = false
        userImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

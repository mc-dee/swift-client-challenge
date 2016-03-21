//
//  UsersSearchResultCell.swift
//  GitHubClient
//
//  Created by Stefan Popp on 14.03.16.
//  Copyright © 2016 Stefan Mayer-Popp. All rights reserved.
//

import UIKit

class UsersSearchResultCell: UITableViewCell {
    private var user: User!

    func configure(forUser user: User!) {
        self.user = user
        
        self.textLabel?.text = user.login
    }
}

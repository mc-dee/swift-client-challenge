//
//  UsersSearchResultCell.swift
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

class UsersSearchResultCell: UITableViewCell {
    private var user: User!

    func configure(forUser user: User!) {
        self.user = user
        
        self.textLabel?.text = user.login
    }
}

//
//  RepositoryCell.swift
//  GitHubClient
//
//  Created by Stefan Mayer-Popp on 14.03.16.
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

import Foundation
import UIKit

class RepositoryCell: UITableViewCell {
    
    
    private var repository: Repository!
    
    // MARK: Configure cell
    /**
    Configures a given cell for given index path
    
    - parameter cell:      UITableViewCell to configure
    - parameter indexPath: indexPath of given cell
    */
    func configure(forRepository repository: Repository!) {
        // Save repository
        self.repository = repository
       
        // Subdetail string
        var detailLabelText = "⭐️ \(repository.stargazers_count!) - "
        if case let desc = repository.description_val where desc?.characters.count > 0 {
            detailLabelText += desc!
        } else {
            detailLabelText += "Keine Beschreibung vorhanden 😕"
        }
        self.detailTextLabel?.text = detailLabelText
        
        // Get description val
        self.textLabel?.text = repository.name
        
        // Some transparency
        self.backgroundColor = UIColor.clearColor()
        self.backgroundView?.backgroundColor = UIColor.clearColor()
    }
}
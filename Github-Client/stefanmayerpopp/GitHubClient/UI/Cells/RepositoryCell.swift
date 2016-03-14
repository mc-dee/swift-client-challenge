//
//  RepositoryCell.swift
//  GitHubClient
//
//  Created by Stefan Mayer-Popp on 14.03.16.
//  Copyright © 2016 Stefan Mayer-Popp. All rights reserved.
//

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
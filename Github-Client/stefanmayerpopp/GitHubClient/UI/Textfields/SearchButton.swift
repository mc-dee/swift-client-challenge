//
//  SearchButton.swift
//  GitHubClient
//
//  Created by Stefan Popp on 12.03.16.
//  Copyright © 2016 Stefan Mayer-Popp. All rights reserved.
//

import UIKit

class SearchButton: UIButton {

    var darkTitleColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.4)
    var lightTitleColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8)

    // MARK: Button utilities
    /**
    Enables or disables the search button. Colorize the button by state
    
    - parameter enable: Bool which specifies if button should be enabled or not
    */
    func setButton(enabled enable: Bool) {
        // Always set status of button
        defer {
            self.enabled = enable
            // set button color
            self.setTitleColor(enabled ? lightTitleColor : darkTitleColor, forState: .Normal)
        }
        
        // Remove animations
        if enable {
            self.layer.removeAllAnimations()
            return
        }
        
    }
}

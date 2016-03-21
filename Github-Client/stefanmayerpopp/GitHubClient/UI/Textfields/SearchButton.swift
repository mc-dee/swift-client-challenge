//
//  SearchButton.swift
//  GitHubClient
//
//  Created by Stefan Popp on 12.03.16.
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

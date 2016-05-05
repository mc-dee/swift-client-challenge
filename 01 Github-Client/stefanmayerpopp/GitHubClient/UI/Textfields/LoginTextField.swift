//
//  LoginTextField.swift
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

import Foundation
import UIKit

class LoginTextField: UITextField {

    /**
     Moves editing rect a bit to left
     
     - parameter bounds: bounds of editing rect
     
     - returns: CGRectInset
     */
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 8, 0)
    }

    /**
     Moves text rect a bit to left
     
     - parameter bounds: bounds of text rect
     
     - returns: CGRectInset
     */
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 8, 0)
    }

}
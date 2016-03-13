//
//  LoginTextField.swift
//  GitHubClient
//
//  Created by Stefan Popp on 12.03.16.
//  Copyright © 2016 Stefan Mayer-Popp. All rights reserved.
//

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
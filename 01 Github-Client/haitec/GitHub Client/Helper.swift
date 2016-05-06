//
//  Helper.swift
//  GitHub Client
//
//  Created by Miguel Dönicke on 13.03.16.
//  Copyright © 2016 Miguel Dönicke. All rights reserved.
//

import Foundation
import UIKit

typealias JSON = [String: AnyObject]

class Helper {

    class func showAlert(title: String, withMessage message: String, inViewController viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        ^{
            viewController.presentViewController(alert, animated: true, completion: nil)
        }
    }

    static func parseJSON(fromData data: NSData) -> [JSON] {
        var result = [JSON]()

        guard let json = try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) else { return result }

        if json is JSON {
            result = [json as! JSON]
        } else {
            result = json as! [JSON]
        }

        return result
    }

}


prefix operator ^ {}

prefix func ^ (block: () -> Void) {
    dispatch_async(dispatch_get_main_queue(), block)
}

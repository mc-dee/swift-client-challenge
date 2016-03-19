//
//  AppDelegate.swift
//  Ben
//
//  Created by Benjamin Herzog on 09.03.16.
//  Copyright © 2016 Benjamin Herzog. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}


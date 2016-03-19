//
//  AppDelegate.swift
//  Dasdom
//
//  Created by dasdom on 09.03.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow? = UIWindow(frame: UIScreen.mainScreen().bounds)

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    let root = UserSearchTableViewController<RepositoryTableViewCell>()
    window?.rootViewController = UINavigationController(rootViewController: root)
    window?.makeKeyAndVisible()
    return true
  }
}


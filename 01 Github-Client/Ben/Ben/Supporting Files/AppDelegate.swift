//
//  AppDelegate.swift
//  Ben
//
//  Created by Benjamin Herzog on 10.03.16.
//  Copyright © 2016 Benjamin Herzog. All rights reserved.
//

import UIKit
import Helper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		
		setupAppearance()
		
		window = UIWindow()
		window?.rootViewController = UserController().wrapInNavigationController()
		window?.makeKeyAndVisible()
		
		return true
	}
	
	private func setupAppearance() {
		UINavigationBar.appearance().barTintColor = UIColor(r: 44, g: 62, b: 80, a: 1.0)
		UINavigationBar.appearance().tintColor = UIColor.whiteColor()
		UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
		
		UIApplication.sharedApplication().statusBarStyle = .LightContent
	}
}

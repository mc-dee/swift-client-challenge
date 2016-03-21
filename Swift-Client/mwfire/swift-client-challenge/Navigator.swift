//
//  Navigator.swift
//  swift-client-challenge
//
//  Created by Martin Wildfeuer on 20.03.16.
//  Copyright © 2016 mwfire development. All rights reserved.
//

import Foundation
import UIKit


class Navigator {
    
    static let sharedNavigator = Navigator()
    
    lazy var root: UINavigationController = {
        let vc = RootViewController()
        vc.view.backgroundColor = UIColor.whiteColor()
        let nc = UINavigationController(rootViewController: vc)
        return nc
    }()
    
    private init() {}
    
    lazy var router = { Router.sharedRouter }()
    
    func push(path: NSURL) {
        guard let path = path.toRoutablePath() else {
            return
        }
        push(path)
    }
    
    func push(path: String) {
        guard let route = router.routeForPath(path) else {
            return
        }
        
        let request = RouteRequest(path: path, route: route)
        pushRouteRequest(request)
    }

    private func pushRouteRequest(routeRequest: RouteRequest) {
        let vc = routeRequest.route.viewController.init()
        if var routableVC = vc as? Routable {
            routableVC.routeRequest = routeRequest
            root.pushViewController(routableVC as! UIViewController, animated: true)
        }
    }
}
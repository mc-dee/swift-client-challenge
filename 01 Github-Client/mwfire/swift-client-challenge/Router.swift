//
//  Router.swift
//  swift-client-challenge
//
//  Created by Martin Wildfeuer on 09.03.16.
//  Copyright © 2016 mwfire development. All rights reserved.
//

import Foundation
import UIKit


public class Router {
    
    static let sharedRouter = Router()
    
    var routes = [Route]()
    
    private init() {}
    
    func registerRoute(path: String, viewController: UIViewController.Type) {
        let route = Route(path: path, viewController: viewController)
        routes.append(route)
    }
    
    func routeForPath(path: String) -> Route? {
        let filteredRoutes = routes
            .filter { (route) -> Bool in
                return route.path.pathComponents.count == path.pathComponents.count &&
                    route.path.pathComponents[0] == path.pathComponents[0]
            }
            .filter { (route) -> Bool in
                var matches = true
                for (index, component) in route.path.pathComponents.enumerate() {
                    if component.isPlaceHolder { continue }
                    if component != path.pathComponents[index] {
                        matches = false
                    }
                }
                return matches
        }
        
        return filteredRoutes.first
    }
}

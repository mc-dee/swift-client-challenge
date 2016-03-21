//
//  RouteRequest.swift
//  swift-client-challenge
//
//  Created by Martin Wildfeuer on 20.03.16.
//  Copyright © 2016 mwfire development. All rights reserved.
//

import Foundation

struct RouteRequest  {
    let path: String
    let route: Route
    
    var options: [String : String] {
        var options = [String : String]()
        for (index, routeComponent) in route.path.pathComponents.enumerate() {
            if routeComponent.isPlaceHolder {
                options[routeComponent] = self.path.pathComponents[index]
            }
        }
        return options
    }
}

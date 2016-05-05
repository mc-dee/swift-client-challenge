//
//  Routable.swift
//  swift-client-challenge
//
//  Created by Martin Wildfeuer on 21.03.16.
//  Copyright © 2016 mwfire development. All rights reserved.
//

import Foundation
import UIKit

protocol Routable {
    var routeRequest: RouteRequest? { get set }
}
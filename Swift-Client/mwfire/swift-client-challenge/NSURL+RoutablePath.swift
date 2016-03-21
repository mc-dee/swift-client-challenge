//
//  NSURL+RoutablePath.swift
//  swift-client-challenge
//
//  Created by Martin Wildfeuer on 21.03.16.
//  Copyright © 2016 mwfire development. All rights reserved.
//

import Foundation

extension NSURL {
    func toRoutablePath() -> String? {
        guard let urlComponents = NSURLComponents(URL: self, resolvingAgainstBaseURL: false) else {
            return nil
        }
        var path = urlComponents.host ?? ""
        path += urlComponents.path ?? ""
        return path
    }
}
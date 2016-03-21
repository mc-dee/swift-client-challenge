//
//  String+ComponentDeconstructable.swift
//  swift-client-challenge
//
//  Created by Martin Wildfeuer on 20.03.16.
//  Copyright © 2016 mwfire development. All rights reserved.
//

import Foundation

//protocol ComponentDeconstructable {
//    var pathComponents: [String] { get }
//    var isPlaceHolder: Bool { get }
//}

extension String {
    var pathComponents: [String] {
        guard let urlComponents = NSURLComponents(string: self) else {
            return []
        }
        
        var path = urlComponents.host ?? ""
        path += urlComponents.path ?? ""
        return path.componentsSeparatedByString("/")
    }
    
    var isPlaceHolder: Bool {
        return self.hasPrefix(":")
    }
}
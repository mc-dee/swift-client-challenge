//
//  Extensions.swift
//  Ben
//
//  Created by Benjamin Herzog on 11/03/16.
//  Copyright © 2016 Benjamin Herzog. All rights reserved.
//

import UIKit

public extension UIViewController {
	
	func wrapInNavigationController() -> UINavigationController {
		if let c = self.navigationController {
			return c
		}
		return UINavigationController(rootViewController: self)
	}
}

public extension Array {
	
	subscript(safe index: Int) -> Element? {
		if index >= count {
			return nil
		}
		return self[index]
	}
}

public extension String {
	
	public var htmlQuery: String {
		return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) ?? self
	}
}

public extension Dictionary {
	
	init < S: SequenceType where S.Generator.Element == (Key, Value) > (_ seq: S) {
		self = [:]
		self.merge(seq)
	}
	
	mutating func merge < S: SequenceType where S.Generator.Element == (Key, Value) > (other: S) {
		for (k, v) in other {
			self[k] = v
		}
	}
	
	func mapValues<T>(op: Value -> T) -> [Key: T] {
		return [Key: T](flatMap { return ($0, op($1)) })
	}
	
	var urlParameterRepresentation: String {
		return reduce("") {
			"\($0)\($0.isEmpty ? "" : "&")\($1.0)=\($1.1)"
		}
	}
}

public extension UIColor {
	
	convenience init(r: Int, g: Int, b: Int, a: CGFloat) {
		self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: a)
	}
	
}

//
//  Mapping.swift
//  Ben
//
//  Created by Benjamin Herzog on 10.03.16.
//  Copyright © 2016 Benjamin Herzog. All rights reserved.
//

import UIKit
import Helper

public typealias JSON = [String: AnyObject]

public protocol Settable { }

public protocol Mappable: Settable {
	
	init?(_ json: JSON)
}

public struct Mapper {
	
	public static func map<T: Mappable>(json: AnyObject) -> (single: T?, array: [T]?) {
		
		var single: T?
		var array: [T]?
		if let dic = json as? JSON {
			single = T(dic)
		}
		if let arr = json as? [JSON] {
			array = arr.map(T.init).filter { $0 != nil }.map { $0! }
		}
		return (single, array)
	}
}

// If you need more, add the protocol conformance :)
extension Int: Settable { }
extension Double: Settable { }
extension Float: Settable { }
extension CGFloat: Settable { }
extension String: Settable { }

infix operator ~~ { }

public func ~~<T: Settable>(inout set: T, value: AnyObject?) {
	if let value = value as? T {
		set = value
	}
}

public func ~~<T: Mappable>(inout set: T, value: AnyObject?) {
	if let value = value as? JSON, mapped = T(value) {
		set = mapped
	}
}

public func ~~<T: Settable>(inout set: T?, value: AnyObject?) {
	if let value = value as? T {
		set = value
	}
}

public func ~~<T: Mappable>(inout set: T?, value: AnyObject?) {
	if let value = value as? JSON, mapped = T(value) {
		set = mapped
	}
}

public func ~~<T: Settable>(inout set: T!, value: AnyObject?) {
	if let value = value as? T {
		set = value
	}
}

public func ~~<T: Mappable>(inout set: T!, value: AnyObject?) {
	if let value = value as? JSON, mapped = T(value) {
		set = mapped
	}
}

public func ~~<T: Mappable>(inout set: [T], value: AnyObject?) {
	if let value = value as? [JSON] {
		var a = [T]()
		value.forEach {
			if let new = T($0) {
				a.append(new)
			}
		}
		set = a
	}
}

public func ~~<T: Mappable, U>(inout set: [U: T], value: AnyObject?) {
	
	if let value = value as? [U: JSON] {
		let mapped = value.mapValues(T.init)
		set = [:]
		mapped.forEach {
			if $1 != nil {
				set[$0] = $1
			}
		}
	}
}

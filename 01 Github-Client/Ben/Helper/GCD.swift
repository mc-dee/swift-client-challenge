//
//  GCD.swift
//  Ben
//
//  Created by Benjamin Herzog on 10.03.16.
//  Copyright © 2016 Benjamin Herzog. All rights reserved.
//

import Foundation

public func main(op: Void -> Void) {
	let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
	dispatch_after(delayTime, dispatch_get_main_queue(), op)
}

//
//  AsynOperation.swift
//  GitHubClient
//
//  Created by Stefan Popp on 13.03.16.
//  Copyright © 2016 Stefan Mayer-Popp. All rights reserved.
//

import UIKit

/**
* UNUSED!
*/

/// Asynchronous operation
class AsyncOperation: NSOperation {
    
    // We are concurrent and asynchronous
    override var concurrent: Bool { return true }
    override var asynchronous: Bool { return true }
    
    // Sigh, we need to save our state in a seperate variable ;(
    // Asked if we are executing
    private var _executing: Bool = false
    override var executing: Bool {
        get {
            return _executing
        }
        set {
            // Ignore same value
            if (_executing == newValue) {
                return
            }
            
            // We need to stay KVO conform with this variable
            self.willChangeValueForKey("isExecuting")
            _executing = newValue
            self.didChangeValueForKey("isExecuting")
        }
    }
    
    // And another variable we have to save seperate
    private var _finished: Bool = false;
    override var finished: Bool {
        get {
            return _finished
        }
        set {
            // We dont care for the same value
            if (_finished == newValue) {
                return
            }
            
            // Tell KVO listener that we changed the value
            self.willChangeValueForKey("isFinished")
            _finished = newValue
            self.didChangeValueForKey("isFinished")
        }
    }
    
    // Operation is finished
    func operationFinished() {
        // Set values and trigger KVO if needed
        executing = false
        finished  = true
    }
    
    override func start() {
        // Check if operation has been cancelled before it even started
        if (cancelled) {
            finished = true
            return
        }
        
        // Start execution
        executing = true
        
        // Run main, kthxbye
        main()
    }
}

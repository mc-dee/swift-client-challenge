//
//  AsynOperation.swift
//  GitHubClient
//
//  Created by Stefan Popp on 13.03.16.
//
//  This file is part of GitHubCLient.
//
//  GitHubCLient is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  GitHubCLient is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with GitHubCLient.  If not, see <http://www.gnu.org/licenses/>.

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

//
//  OperationManager.swift
//  GitHubClient
//
//  Created by Stefan Popp on 12.03.16.
//  Copyright © 2016 Stefan Mayer-Popp. All rights reserved.
//

import UIKit

class OperationManager {
    // Singleton should be used for normal operation queue.
    static let sharedInstance = OperationManager()
    
    // Operation queue
    let operationQueue = NSOperationQueue()
    
    init() {
        // Set max concurrent operations
        operationQueue.maxConcurrentOperationCount = 4
    }
}

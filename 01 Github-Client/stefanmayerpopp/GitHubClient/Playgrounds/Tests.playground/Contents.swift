
for i in 0...100 {
    var hasPrefix = false
    
    if i % 2 == 0 {
        hasPrefix = true
    }
    defer {
        if hasPrefix {
            print("I have a prefix \(i)")
        }
    }
    
    
}


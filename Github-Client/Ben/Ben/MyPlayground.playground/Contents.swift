// : Playground - noun: a place where people can play

import Cocoa

var ax = [Any]()
let f: [Int]? = [1, 2, 3, 4, 5]
ax += f.map { $0.map { $0 } } ?? []
ax += f?.flatMap { $0 as Any } ?? []
ax += f.flatMap { $0.map { $0 } } ?? []
print(ax)
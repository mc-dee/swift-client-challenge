// ---------------------------------------------------
//  PlainTableDataSource.swift
//  GitHubClientChallenge
//
//  Created by Michael on 19.03.2016.
//  Copyright © 2016 Michael Fenske. See LICENSE.txt.
// ---------------------------------------------------


import UIKit


class PlainTableDataSource<C, I> : NSObject, UITableViewDataSource {

    typealias Configure = (cell: C, item: I) -> Void

    private let items: [I]
    private let cellIdentifier: String
    private let configureCell: Configure


    init(items: [I], cellIdentifier: String, configureCell: Configure) {
        self.items = items
        self.cellIdentifier = cellIdentifier
        self.configureCell = configureCell

        super.init()
    }


    func itemAtIndexPath(indexPath: NSIndexPath) -> I {
        return items[indexPath.row]
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! C
        configureCell(cell: cell, item: itemAtIndexPath(indexPath))

        return cell as! UITableViewCell
    }
}

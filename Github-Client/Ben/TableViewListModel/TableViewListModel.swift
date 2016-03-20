//
//  ViewController.swift
//  Ben
//
//  Created by Benjamin Herzog on 10.03.16.
//  Copyright © 2016 Benjamin Herzog. All rights reserved.
//

import UIKit
import Network
import Mapper
import Helper

// MARK: - Protocols

public protocol ViewModelType {
	typealias ObjectType: Mappable, Identifiable
	
	init(model: ObjectType)
}

public protocol Cell: class {
	typealias ViewModel: ViewModelType
	
	static func heightWithModel(model: ViewModel.ObjectType) -> CGFloat
	
	func setup(object: ViewModel, indexPath: NSIndexPath)
}

public extension Cell {
	static func heightWithModel(model: ViewModel.ObjectType) -> CGFloat {
		return 50
	}
}

public protocol Identifiable { }
public extension Identifiable {
	static var identifier: String {
		return String(self)
	}
	var identifier: String {
		return self.dynamicType.identifier
	}
}

// MARK: - Model base class

public class TableViewListModel<CellType: Cell>: NSObject, UITableViewDelegate, UITableViewDataSource {
	
	public private(set) weak var tableView: UITableView?
	
	public init(tableView: UITableView) {
		self.tableView = tableView
		
		configurator = {
			cell, object, indexPath in
			
			let viewModel = CellType.ViewModel(model: object)
			
			cell.setup(viewModel, indexPath: indexPath)
		}
		
		super.init()
		tableView.delegate = self
		tableView.dataSource = self
		
		tableView.registerClass(CellType.self, forCellReuseIdentifier: CellType.ViewModel.ObjectType.identifier)
		
		
	}
	
	public var items = Array<CellType.ViewModel.ObjectType>()
	
	public func addObjects(objects: [CellType.ViewModel.ObjectType]) {
		self.items += objects
		
		main {
			self.tableView?.reloadData()
		}
	}
	
	public func addObjectsFromResponse(response: Response<CellType.ViewModel.ObjectType>) {
		self.items += response.object.map { [$0] } ?? []
		
		self.items += response.objects?.flatMap { $0 as CellType.ViewModel.ObjectType } ?? []
		
		main {
			self.tableView?.reloadData()
		}
	}
	
	typealias CellConfigurator = (cell: CellType, object: CellType.ViewModel.ObjectType, indexPath: NSIndexPath) -> Void
	private var configurator: CellConfigurator
	
	typealias CellAction = (object: CellType.ViewModel.ObjectType, indexPath: NSIndexPath) -> Void
	private var cellAction: CellAction?
	
	public func registerCellAction(action: ((object: CellType.ViewModel.ObjectType, indexPath: NSIndexPath) -> Void)? = nil) {
		cellAction = action
	}
	
	// MARK : TableView Delegate & DataSource
	
	public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		guard let item = items[safe: indexPath.row] else {
			print("Item is no identifiable!")
			return 50
		}
		
		return CellType.heightWithModel(item)
	}
	
	public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		guard let item = items[safe: indexPath.row] else {
			print("Item is no identifiable!")
			let cell = UnknownCell()
			cell.item = items[indexPath.row]
			return cell
		}
		
		let identifier = item.identifier
		
		guard let cell = tableView.dequeueReusableCellWithIdentifier(identifier) else {
			print("No cell registered!")
			let cell = UnknownCell()
			cell.item = items[indexPath.row]
			return cell
		}
		
		return cell
	}
	
	public func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
		
		if cell is UnknownCell {
			return
		}
		
		guard let item = items[safe: indexPath.row],
			cell = cell as? CellType else {
				return
		}
		
		configurator(cell: cell, object: item, indexPath: indexPath)
	}
	
	public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		guard let item = items[safe: indexPath.row] else {
			return
		}
		cellAction?(object: item, indexPath: indexPath)
	}
}

// MARK: - Helper Cell

class UnknownCell: UITableViewCell {
	
	var item: Any? {
		didSet {
			textLabel?.text = "Unkown type: \(item)"
		}
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: .Default, reuseIdentifier: reuseIdentifier)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

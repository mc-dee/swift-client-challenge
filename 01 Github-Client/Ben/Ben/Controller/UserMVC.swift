//
//  UserViewController.swift
//  Ben
//
//  Created by Benjamin Herzog on 10.03.16.
//  Copyright © 2016 Benjamin Herzog. All rights reserved.
//

import UIKit
import TableViewListModel

class UserController: Table {
	
	private lazy var model: UserListModel = {
		return UserListModel(tableView: self.tableView)
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let frame = CGRect(x: 0, y: 0, width: view.bounds.size.width * 0.6, height: 25)
		let t = TextField(frame: frame) {
			[weak self] t in
			guard let term = t.text where !term.isEmpty else {
				self?.model.items.removeAll(keepCapacity: true)
				self?.tableView.reloadData()
				return
			}
			self?.model.startLoading(userName: term)
		}
		navigationItem.titleView = t
		
		model.registerCellAction {
			[weak self] object, indexPath in
			self?.goToRepos(object)
		}
		
		t.becomeFirstResponder()
	}
	
	private func goToRepos(user: User) {
		let vc = RepoController()
		vc.user = user
		navigationController?.pushViewController(vc, animated: true)
	}
}

class UserCell: TableCell, Cell {
	
	func setup(object: UserViewModel, indexPath: NSIndexPath) {
		textLabel?.text = object.user.userName
		detailTextLabel?.text = object.user.biography
	}
}

class UserListModel: TableViewListModel<UserCell> {
	
	override init(tableView: UITableView) {
		super.init(tableView: tableView)
	}
	
	func startLoading(userName userName: String, force: Bool = true) {
		
		if force {
			items.removeAll(keepCapacity: true)
		}
		
		UserSearchEndpoint(searchTerm: userName).request {
			[weak self] response in
			
			let items = response.object?.items ?? []
			
			self?.addObjects(items)
			}.fire()
	}
}

//
//  RepoMVC.swift
//  Ben
//
//  Created by Benjamin Herzog on 10.03.16.
//  Copyright © 2016 Benjamin Herzog. All rights reserved.
//

import UIKit
import TableViewListModel

class RepoController: Table {
	
	private lazy var model: RepoListModel = {
		return RepoListModel(tableView: self.tableView)
	}()
	
	var user: User?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		model.registerCellAction {
			[weak self] object, indexPath in
			
			self?.didSelectRepo(object)
		}
		
		guard let user = user else {
			model.items = []
			tableView.reloadData()
			return
		}
		title = user.userName
		model.startLoading(user: user)
	}
	
	private func didSelectRepo(repo: Repository) {
		let readme = ReadmeController()
		readme.repo = repo
		navigationController?.pushViewController(readme, animated: true)
	}
}

class RepoListModel: TableViewListModel<RepoCell> {
	
	override init(tableView: UITableView) {
		super.init(tableView: tableView)
	}
	
	func startLoading(user user: User, force: Bool = true) {
		
		if force {
			items.removeAll(keepCapacity: true)
		}
		
		RepositoriesEndpoint(user: user).request {
			[weak self] response in
			
			self?.addObjectsFromResponse(response)
			}.fire()
	}
}

class RepoCell: TableCell, Cell {
	
	func setup(object: RepoViewModel, indexPath: NSIndexPath) {
		textLabel?.text = object.repo.name
		detailTextLabel?.text = object.detailsString
	}
}

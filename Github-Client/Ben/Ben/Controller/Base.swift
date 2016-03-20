//
//  Controller.swift
//  Ben
//
//  Created by Benjamin Herzog on 10.03.16.
//  Copyright © 2016 Benjamin Herzog. All rights reserved.
//

import UIKit
import TableViewListModel

typealias Controller = UIViewController
typealias Table = UITableViewController

class TableCell: UITableViewCell {
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class TextField: UITextField {
	
	var onReturn: TextField -> Void
	
	init(frame: CGRect, onReturn: TextField -> Void) {
		self.onReturn = onReturn
		super.init(frame: frame)
		borderStyle = .RoundedRect
		delegate = self
		clearsOnBeginEditing = true
		autocapitalizationType = .None
		autocorrectionType = .No
		font = UIFont.systemFontOfSize(15)
		
		placeholder = "Gib den Github-Namen ein"
		returnKeyType = .Search
		clearButtonMode = .Always
		contentVerticalAlignment = .Center
		
		textAlignment = .Center
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension TextField: UITextFieldDelegate {
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		onReturn(self)
		return true
	}
	
	func textFieldShouldClear(textField: UITextField) -> Bool {
		text = ""
		onReturn(self)
		return true
	}
}

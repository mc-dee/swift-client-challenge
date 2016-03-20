//
//  RepositoryTableViewCell.swift
//  Dasdom
//
//  Created by dasdom on 13.03.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell, CellProtocol {
  
  let nameLabel: UILabel
  let descriptionLabel: UILabel
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    nameLabel = UILabel()
    nameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    
    descriptionLabel = UILabel()
    descriptionLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    descriptionLabel.numberOfLines = 2
    
    let stackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .Vertical
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview(stackView)
    
    let views = ["stackView": stackView]
    var layoutConstraints = [NSLayoutConstraint]()
    layoutConstraints += NSLayoutConstraint.constraintsWithVisualFormat("|-[stackView]-|", options: [], metrics: nil, views: views)
    layoutConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[stackView]-|", options: [], metrics: nil, views: views)
    NSLayoutConstraint.activateConstraints(layoutConstraints)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configCell(item: Any) {
    if let item = item as? LabelsPresentable {
      let texts = item.texts
      if texts.count > 0 {
        nameLabel.text = texts[0]
      }
      if texts.count > 1 && texts[1].characters.count > 0 {
        descriptionLabel.text = texts[1]
      }
    }
  }
}

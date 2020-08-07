//
//  BaseCell.swift
//  Revo
//
//  Created by Bryan Nguyen on 8/4/20.
//  Copyright © 2020 Bryan Nguyen. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupViews() {}
}

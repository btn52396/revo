//
//  LabelCell.swift
//  Revo
//
//  Created by Bryan Nguyen on 8/4/20.
//  Copyright © 2020 Bryan Nguyen. All rights reserved.
//

import UIKit

class LabelCell: BaseCell {
    private let indexLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    internal override func setupViews() {
        addSubview(indexLabel)
        setupIndexLabel()
    }
    
    public func setValues(index: Int) {
        indexLabel.text = String(index)
    }
    
    private func setupIndexLabel() {
        indexLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        indexLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

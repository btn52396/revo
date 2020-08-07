//
//  MenuCell.swift
//  Revo
//
//  Created by Bryan Nguyen on 8/7/20.
//  Copyright © 2020 Bryan Nguyen. All rights reserved.
//

import UIKit

class HomeCell: BaseCell {
    private let label: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews() {
        addSubview(label)
        setupLabel()
    }
    
    func setValues(color: UIColor, title: String) {
        backgroundColor = color
        label.text = title
    }
    
    private func setupLabel() {
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

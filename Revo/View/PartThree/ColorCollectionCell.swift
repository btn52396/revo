//
//  ColorCollectionCell.swift
//  Revo
//
//  Created by Bryan Nguyen on 8/7/20.
//  Copyright © 2020 Bryan Nguyen. All rights reserved.
//

import UIKit

class ColorCollectionCell: UICollectionViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }
    
    public func setupViews(color: UIColor, value: Int) {
        backgroundColor = color
    }
    
    private func setupLabel() {
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

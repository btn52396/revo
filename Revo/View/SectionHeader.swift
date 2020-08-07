//
//  SectionHeader.swift
//  Revo
//
//  Created by Bryan Nguyen on 8/5/20.
//  Copyright © 2020 Bryan Nguyen. All rights reserved.
//

import UIKit

class SectionHeader: UIView {
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupView()
    }
    
    private func setupView() {
        addSubview(label)
        setupLabel()
        backgroundColor = .lightGray
    }
        
    private func setupLabel() {
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

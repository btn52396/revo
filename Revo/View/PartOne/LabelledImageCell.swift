//
//  LabelledImageCell.swift
//  Revo
//
//  Created by Bryan Nguyen on 8/5/20.
//  Copyright © 2020 Bryan Nguyen. All rights reserved.
//

import UIKit

class LabelledImageCell: BaseCell {
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    internal override func setupViews() {
        addSubview(logo)
        addSubview(label)
        setupLogo()
        setupLabel()
    }
    
    public func setValues(labelledImage: LabelledImage) {
        label.text = labelledImage.label
        logo.image = UIImage(named: labelledImage.imageName)
    }
    
    private func setupLogo() {
        logo.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        logo.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
    }
    
    private func setupLabel() {
        label.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 5).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}

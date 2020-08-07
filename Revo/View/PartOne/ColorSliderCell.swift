//
//  ColorSliderCell.swift
//  Revo
//
//  Created by Bryan Nguyen on 8/5/20.
//  Copyright © 2020 Bryan Nguyen. All rights reserved.
//

import UIKit

class ColorSliderCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource {
    private let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let colorCellId = "ColorCellId"
        
    internal override func setupViews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ColorRoundCell.self, forCellWithReuseIdentifier: colorCellId)
        addSubview(collectionView)
        
        // Fill entire cell
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": collectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": collectionView]))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: colorCellId, for: indexPath) as! ColorRoundCell
        cell.setupViews(color: .random(), value: indexPath.row)
        return cell
    }
}

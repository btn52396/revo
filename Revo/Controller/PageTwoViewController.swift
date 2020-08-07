//
//  PageTwoViewController.swift
//  Revo
//
//  Created by Bryan Nguyen on 8/3/20.
//  Copyright © 2020 Bryan Nguyen. All rights reserved.
//

import UIKit

class PageTwoViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let colorCollectionCellId = "ColorCollectionCellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Part 3"
        
        setupCollectionView()
        setupMenuBar()
    }
    
    private func setupMenuBar() {
        setupCollectionView()
    }
    
    func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = 10
        }
        
        collectionView.register(ColorCollectionCell.self, forCellWithReuseIdentifier: colorCollectionCellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        
        collectionView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: colorCollectionCellId, for: indexPath) as! ColorCollectionCell
        cell.setupViews(color: .random(), value: indexPath.row)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 10) / 2, height: 100)

    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
}

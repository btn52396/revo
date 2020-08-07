//
//  BonusViewController.swift
//  Revo
//
//  Created by Bryan Nguyen on 8/3/20.
//  Copyright © 2020 Bryan Nguyen. All rights reserved.
//

import UIKit

class BonusViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let doubleCellId = "doubleCellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Part 3"
        
        setupCollectionView()
        setupMenuBar()
    }
    
    private func setupMenuBar() {
//        navigationController?.hidesBarsOnSwipe = true
        
//        let redView = UIView()
//        redView.backgroundColor = UIColor.red
//        view.addSubview(redView)
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": redView]))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(50)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": redView]))
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)

        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView.register(DoubleCell.self, forCellWithReuseIdentifier: doubleCellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        
//        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
//        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
//        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
        
//        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
//        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        collectionView?.isPagingEnabled = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: doubleCellId, for: indexPath) as! DoubleCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width, height: view.frame.height)
    }
    
    // initialized with a non-nil layout parameter
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
}

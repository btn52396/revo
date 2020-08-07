//
//  HomeViewController.swift
//  Revo
//
//  Created by Bryan Nguyen on 8/7/20.
//  Copyright © 2020 Bryan Nguyen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    private func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4.0
        return button
    }
    
    var partOneButton: UIButton!
    var partTwoButton: UIButton!
    var bonusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Home"
        setupViews()
    }
    
    func setupViews() {
        partOneButton = createButton(title: "Part One")
        partTwoButton = createButton(title: "Part Two")
        bonusButton = createButton(title: "Bonus")
        
        partOneButton.addTarget(self, action: #selector(presentPartOne), for: .touchUpInside)
        partTwoButton.addTarget(self, action: #selector(presentPartTwo), for: .touchUpInside)
        bonusButton.addTarget(self, action: #selector(presentBonus), for: .touchUpInside)
        
        
        view.addSubview(partOneButton)
        view.addSubview(partTwoButton)
        view.addSubview(bonusButton)
        
        setupPartTwoButton()
        setupPartOneButton()
        setupBonusButton()
    }
    
    private func setupPartOneButton() {
        partOneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        partOneButton.bottomAnchor.constraint(equalTo: partTwoButton.topAnchor, constant: -30).isActive = true
        partOneButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        partOneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupPartTwoButton() {
        partTwoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        partTwoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        partTwoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        partTwoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupBonusButton() {
        bonusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bonusButton.topAnchor.constraint(equalTo: partTwoButton.bottomAnchor, constant: 30).isActive = true
        bonusButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        bonusButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func presentPartOne() {
        navigationController?.pushViewController(TableViewController(), animated: true)
    }
    
    @objc func presentPartTwo() {
        navigationController?.pushViewController(AVPlayerViewController(), animated: true)
    }
    
    @objc func presentBonus() {
        navigationController?.pushViewController(PageController(), animated: true)
    }
}

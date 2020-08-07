//
//  PageOneViewController.swift
//  Revo
//
//  Created by Bryan Nguyen on 8/7/20.
//  Copyright © 2020 Bryan Nguyen. All rights reserved.
//

import UIKit

class PageOneViewController: UITableViewController {
    var cellId = "ColorTableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        
        tableView.register(ColorTableCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ColorTableCell
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

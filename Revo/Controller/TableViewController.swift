//
//  TableViewController.swift
//  Revo
//
//  Created by Bryan Nguyen on 8/3/20.
//  Copyright © 2020 Bryan Nguyen. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    let labelledImageCellId = "labelledImageCellId"
    let colorSliderCellId = "colorSliderCellId"
    let labelCellId = "labelCellId"
    
    override func viewDidLoad() {
        self.navigationItem.title = "Part 1"
        setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(LabelledImageCell.self, forCellReuseIdentifier: labelledImageCellId)
        self.tableView.register(ColorSliderCell.self, forCellReuseIdentifier: colorSliderCellId)
        self.tableView.register(LabelCell.self, forCellReuseIdentifier: labelCellId)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: labelledImageCellId, for: indexPath) as! LabelledImageCell
            cell.setValues(labelledImage: LabelledImage(label: "Revo", imageName: "revoLogo"))
            cell.isUserInteractionEnabled = false
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: colorSliderCellId, for: indexPath) as! ColorSliderCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: labelCellId, for: indexPath) as! LabelCell
            cell.setValues(index: indexPath.row)
            cell.isUserInteractionEnabled = false
            return cell
        default: break
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return 100
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 125
        case 1: return 70
        case 2: return 50
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 100
        case 1: return 50
        case 2: return 50
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader: SectionHeader = {
            let sectionHeader = SectionHeader()
            switch section {
            case 0: sectionHeader.label.text = "Section 1"
            case 1: sectionHeader.label.text = "Section 2"
            case 2: sectionHeader.label.text = "Section 3"
            default: break
            }
            return sectionHeader
        }()
        
        return sectionHeader
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

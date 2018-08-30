//
//  TableViewCell.swift
//  Hyperion-Plugin-Example
//
//  Created by Hiroshi Hosoda on 2018/08/22.
//  Copyright © 2018年 Hiroshi Hosoda. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier: String = "TableViewCell"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    func config(model: GithubRepositoryModel.Item) {
        nameLabel.text = model.full_name
        languageLabel.text = model.language
    }
    
}

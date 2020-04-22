//
//  SearchTableViewCell.swift
//  GtihubSearch
//
//  Created by Jure Čular on 21/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

import UIKit

protocol SearchTableViewCellItem {
    var repositoryName: String { get }
    var lastUpdateDate: String { get }
}

final class SearchTableViewCell: UITableViewCell {
    func configure(item: SearchTableViewCellItem) {
        self.textLabel?.text = item.repositoryName
        self.detailTextLabel?.text = item.lastUpdateDate
    }
}


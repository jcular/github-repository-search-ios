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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
        detailTextLabel?.text = nil
    }

    func configure(item: SearchTableViewCellItem) {
        accessoryType = .disclosureIndicator
        textLabel?.text = item.repositoryName
        detailTextLabel?.text = item.lastUpdateDate
    }
}


//
//  RepositoryDetailView.swift
//  GithubSearch
//
//  Created by Jure Čular on 22/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

import UIKit

final class RepositoryDetailView: UIView {
    
    init(labelText: String, detailText: String?, font: UIFont = UIFont.systemFont(ofSize: 17)) {
        super.init(frame: .zero)
        _setup(labelText: labelText, detailText: detailText, font: font)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup -
    
    private func _setup(labelText: String, detailText: String?, font: UIFont = UIFont.systemFont(ofSize: 17)) {
        let stackView = UIStackView()
        _setup(stackView: stackView)
        
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = UIColor.lightGray
        descriptionLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        descriptionLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        _setup(label: descriptionLabel, withText: labelText, font: font, inStackView: stackView)
        
        let detailLabel = UILabel()
        detailLabel.lineBreakMode = .byWordWrapping
        detailLabel.numberOfLines = 0
        _setup(label: detailLabel, withText: detailText, font: font, inStackView: stackView)
        
        
    }
    
    private func _setup(stackView: UIStackView) {
        let spacingConstant: CGFloat = 3
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.spacing = spacingConstant
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func _setup(label: UILabel, withText text: String?, font: UIFont, inStackView stackView: UIStackView) {
        label.text = text
        label.font = font
        label.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(label)
    }
}

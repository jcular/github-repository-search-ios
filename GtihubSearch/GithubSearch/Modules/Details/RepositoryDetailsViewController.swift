//
//  RepositoryDetailsViewController.swift
//  GtihubSearch
//
//  Created by Jure Čular on 22/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

import UIKit

protocol RepositoryDetails {
    var repositoryName: String { get }
    var lastUpdateDate: String { get }
    var ownerName: String { get }
    var description: String? { get }
}

extension Repository: RepositoryDetails {
    var ownerName: String {
        return owner.name
    }
}

final class RepositoryDetailsViewController: UIViewController {
    private let _repositoryDetails: RepositoryDetails
    
    init(repositoryDetails: RepositoryDetails) {
        _repositoryDetails = repositoryDetails
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.systemBackground
        
        title = _repositoryDetails.repositoryName
        
        let scrollView = UIScrollView()
        _setup(scrollView: scrollView)
        
        let stackView = UIStackView()
        _setup(stackView: stackView, inScrollView: scrollView)
        
        let repositoryDetailsLabelText = NSLocalizedString("repositoryDetailsName", comment: "")
        
        let repositoryNameDetailView = RepositoryDetailView(labelText: "\(repositoryDetailsLabelText):", detailText: _repositoryDetails.repositoryName, font: UIFont.systemFont(ofSize: 20))
        _setupDetailLabel(repositoryDetailView: repositoryNameDetailView, inView: stackView)
        
        let repositoryDescriptionLabelText = NSLocalizedString("repositoryDetailsDescription", comment: "")
        let repositoryDescriptionDetailView = RepositoryDetailView(labelText: "\(repositoryDescriptionLabelText):", detailText: _repositoryDetails.description, font: UIFont.systemFont(ofSize: 18))
        _setupDetailLabel(repositoryDetailView: repositoryDescriptionDetailView, inView: stackView)
        
        let repositoryOwnerNameLabelText = NSLocalizedString("repositoryDetailsOwnerName", comment: "")
        let repositoryOwnerNameDetailView = RepositoryDetailView(labelText: "\(repositoryOwnerNameLabelText):", detailText: _repositoryDetails.ownerName, font: UIFont.systemFont(ofSize: 17))
        _setupDetailLabel(repositoryDetailView: repositoryOwnerNameDetailView, inView: stackView)
        
        let repositoryUpdateTimeLabelText = NSLocalizedString("repositoryDetailsUpdateTime", comment: "")
        let lastUpdateTimeDetailView = RepositoryDetailView(labelText: "\(repositoryUpdateTimeLabelText):", detailText: _repositoryDetails.lastUpdateDate, font: UIFont.systemFont(ofSize: 15))
        _setupDetailLabel(repositoryDetailView: lastUpdateTimeDetailView, inView: stackView)
        
        
    }
    
    // MARK: - Setup -
    private func _setup(stackView: UIStackView, inScrollView scrollView: UIScrollView) {
        let spacingConstant: CGFloat = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = spacingConstant
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    private func _setup(scrollView: UIScrollView) {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func _setupDetailLabel(repositoryDetailView: RepositoryDetailView, inView stackView: UIStackView) {
        repositoryDetailView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(repositoryDetailView)
        
        NSLayoutConstraint.activate([
            repositoryDetailView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}

//
//  SearchViewController.swift
//  GtihubSearch
//
//  Created by Jure Čular on 21/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, SearchServiceDelegate {
    private var _searchController: UISearchController
    private let _tableView: UITableView
    
    private let _searchService: SearchServiceInterface
    private let _searchViewRouter: SearchViewRouter
    private var _repositories: [Repository]?
    
    init(searchService: SearchServiceInterface, searchViewRouter: SearchViewRouter) {
        _tableView = UITableView(frame: .zero)
        _searchService = searchService
        _searchViewRouter = searchViewRouter
        _searchController = UISearchController(searchResultsController: nil)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("searchViewControllerTitlte", comment: "")
        
        _setupTableView(tableView: _tableView)
        _setupSearchController(searchController: _searchController)
    }
    
    // MARK: - Setup -
    
    private func _setupTableView(tableView: UITableView) {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        _tableView.dataSource = self
        _tableView.delegate = self
        _tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
    }
    
    private func _setupSearchController(searchController: UISearchController) {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
    }
    
    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchString = searchBar.text else { return }
        _searchService.searchRepositories(searchQuery: searchString)
    }
    
    // MARK: - UITableViewDelegate -
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _tableView.deselectRow(at: indexPath, animated: true)
        guard let repository = _repositories?[indexPath.row] else { return }
        _searchViewRouter.navigate(to: .repositoryDetails(repository))
    }
    
    // MARK: - UITableViewDataSource -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _repositories?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "SearchTableViewCell",
            for: indexPath
            ) as? SearchTableViewCell else {
                fatalError("Invalid cell type for table view")
        }

        guard let item = _repositories?[indexPath.row] else {
                fatalError("Invalid cell type for table view")
        }
        cell.configure(item: item)

        cell.selectionStyle = .none
        return cell
    }
    // MARK: - SearchServiceDelegate -
    
    func successfullyRetrieved(repositories: [Repository]) {
        DispatchQueue.main.async {
            self._repositories = repositories
            self._tableView.reloadData()
        }
    }
    
    func failed(withError error: Error) {
        DispatchQueue.main.async {
            self._searchViewRouter.showErrorAlert(with: error.localizedDescription)
        }
    }
}

extension Repository: SearchTableViewCellItem {
    var repositoryName: String {
        return name
    }
    
    var lastUpdateDate: String {
        guard let lastUpdateTime = lastUpdateTime else {
            return ""
        }
        return lastUpdateTime.displayDate()
    }
}

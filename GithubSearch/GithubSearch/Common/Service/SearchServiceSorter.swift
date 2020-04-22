//
//  SearchServiceSorter.swift
//  GithubSearch
//
//  Created by Jure Čular on 22/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

import Foundation

final class SearchServiceSorter: SearchServiceInterface, SearchServiceDelegate {
    private var _searchService: SearchServiceInterface
    
    var delegate: SearchServiceDelegate?
    
    init(searchService: SearchServiceInterface) {
        _searchService = searchService
        _searchService.delegate = self
    }
    
    // MARK: - SearchServiceInterface -
    
    func searchRepositories(searchQuery query: String) {
        _searchService.searchRepositories(searchQuery: query)
    }
    
    // MARK: - SearchServiceDelegate -
    
    func successfullyRetrieved(repositories: [Repository], forQuery query: String) {
        let sortedRepositories = _sortRepositoriesByDate(repositories: repositories)
        delegate?.successfullyRetrieved(repositories: sortedRepositories, forQuery: query)
    }
    
    func failed(withError error: Error) {
        delegate?.failed(withError: error)
    }
    
    // MARK: - Private -
    
    private func _sortRepositoriesByDate(repositories: [Repository]) -> [Repository] {
        return repositories.sorted { (repository1, repository2) -> Bool in
            guard let firstRepositoryTime = repository1.lastUpdateTime else {
                return false
            }
            
            guard let secondRepositoryTime = repository2.lastUpdateTime else {
                return true
            }
            
            return firstRepositoryTime > secondRepositoryTime
        }
    }
    
}

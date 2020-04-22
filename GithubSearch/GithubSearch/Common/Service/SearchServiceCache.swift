//
//  SearchServiceCache.swift
//  GithubSearch
//
//  Created by Jure Čular on 22/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

import Foundation

fileprivate class CachedRepository {
    let repositories: [Repository]
    
    init(repositories: [Repository]) {
        self.repositories = repositories
    }
}

final class SearchServiceCache: SearchServiceInterface, SearchServiceDelegate {
    private var _cache: NSCache<NSString, CachedRepository>
    private var _searchService: SearchServiceInterface
    
    var delegate: SearchServiceDelegate?
    
    init(searchService: SearchServiceInterface) {
        _cache = NSCache()
        _searchService = searchService
        _searchService.delegate = self
    }
    
    // MARK: - SearchServiceInterface -
    
    func searchRepositories(searchQuery query: String) {
        if let cachedObject = _cache.object(forKey: query as NSString)?.repositories {
            delegate?.successfullyRetrieved(repositories: cachedObject, forQuery: query)
        } else {
            _searchService.searchRepositories(searchQuery: query)
        }
    }
    
    // MARK: - SearchServiceDelegate -
    
    func successfullyRetrieved(repositories: [Repository], forQuery query: String) {
        _cache.setObject(CachedRepository(repositories: repositories), forKey: query as NSString)
        delegate?.successfullyRetrieved(repositories: repositories, forQuery: query)
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

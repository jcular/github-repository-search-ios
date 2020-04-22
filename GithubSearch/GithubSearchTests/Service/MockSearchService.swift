//
//  MockSearchService.swift
//  GithubSearchTests
//
//  Created by Jure Čular on 22/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

import Foundation

final class MockSearchService: SearchServiceInterface {
    var delegate: SearchServiceDelegate?
    
    private var _repositories: [Repository]?
    private var _error: APIError?
    
    
    init(repositoies: [Repository]) {
        _repositories = repositoies
    }
    
    init(error: APIError) {
        _error = error
    }
    
    func searchRepositories(searchQuery query: String) {
        if let repositories = _repositories {
            delegate?.successfullyRetrieved(repositories: repositories, forQuery: query)
        } else if let error = _error {
            delegate?.failed(withError: error)
        }
    }
    
}

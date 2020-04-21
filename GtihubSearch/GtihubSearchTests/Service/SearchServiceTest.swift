//
//  SearchServiceTest.swift
//  GtihubSearch
//
//  Created by Jure Čular on 21/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

import XCTest
@testable import GtihubSearch

fileprivate class MockSearchServiceDelegate: SearchServiceDelegate {
    private let _successfullCallback: (([Repository]) -> Void)
    private let _errorCallback: ((Error) -> Void)
    
    init(successfullCallback: @escaping (([Repository]) -> Void), errorCallback: @escaping ((Error) -> Void)) {
        _successfullCallback = successfullCallback;
        _errorCallback = errorCallback;
    }
    
    func successfullyRetrieved(repositories: [Repository]) {
        _successfullCallback(repositories)
    }
    
    func failed(withError error: APIError) {
        _errorCallback(error)
    }
}

final class SearchServieTests: XCTestCase {
    private let _searchServiceInterface: SearchService = SearchService()
    
    func testEmptyQueryRequest() {
        // Setup
        let expectation = XCTestExpectation(description: "Failed retrieving repositories")
        let mockDelegate = MockSearchServiceDelegate(successfullCallback: { (repositories) in
        }, errorCallback: { (error) in
            expectation.fulfill()
        })
        _searchServiceInterface.delegate = mockDelegate
        let query = ""
        
        // Test
        _searchServiceInterface.searchRepositories(searchQuery: query)
        
         wait(for: [expectation], timeout: 5.0)
    }
    
    func testQueryRequest() {
        // Setup
        let expectation = XCTestExpectation(description: "Failed retrieving repositories")
        let mockDelegate = MockSearchServiceDelegate(successfullCallback: { (repositories) in
            expectation.fulfill()
        }, errorCallback: { (error) in
            XCTFail(error.localizedDescription)
        })
        _searchServiceInterface.delegate = mockDelegate
        let query = "a"
        
        // Test
        _searchServiceInterface.searchRepositories(searchQuery: query)
        
         wait(for: [expectation], timeout: 5.0)
    }

    
}

//
//  SearchServiceCacheTest.swift
//  GithubSearchTests
//
//  Created by Jure Čular on 22/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

import XCTest
@testable import GtihubSearch

fileprivate final class SearchServiceSpy: SearchServiceInterface{
    private(set) var callCounter: Int = 0
    
    var delegate: SearchServiceDelegate?
    
    func searchRepositories(searchQuery query: String) {
        callCounter += 1
        delegate?.successfullyRetrieved(repositories: [], forQuery: query)
    }
}

class SearchServiceCacheTest: XCTestCase {

    func testCachingSameQuery() {
        // Setup
        let searchServiceSpy = SearchServiceSpy()
        let searchService = SearchServiceCache(searchService: searchServiceSpy)
        let expectation = XCTestExpectation(description: "Failed retrieving repositories")
        let mockDelegate = MockSearchServiceDelegate(successfullCallback: { (repositories) in
            XCTAssert(searchServiceSpy.callCounter == 1)
            expectation.fulfill()
        }, errorCallback: { (error) in
            XCTFail(error.localizedDescription)
        })
        searchService.delegate = mockDelegate
        let query = "a"
        
        // Test
        searchService.searchRepositories(searchQuery: query)
        searchService.searchRepositories(searchQuery: query)
        
         wait(for: [expectation], timeout: 5.0)
    }
    
    func testCachingDifferentQuery() {
        // Setup
        let searchServiceSpy = SearchServiceSpy()
        let searchService = SearchServiceCache(searchService: searchServiceSpy)
        let expectation = XCTestExpectation(description: "Failed retrieving repositories")

        let query1 = "a"
        searchService.searchRepositories(searchQuery: query1)
        
        let mockDelegate = MockSearchServiceDelegate(successfullCallback: { (repositories) in
            XCTAssert(searchServiceSpy.callCounter == 2)
            expectation.fulfill()
        }, errorCallback: { (error) in
            XCTFail(error.localizedDescription)
        })
        searchService.delegate = mockDelegate
        let query2 = "b"
        // Test
        searchService.searchRepositories(searchQuery: query2)
        
         wait(for: [expectation], timeout: 5.0)
    }
}

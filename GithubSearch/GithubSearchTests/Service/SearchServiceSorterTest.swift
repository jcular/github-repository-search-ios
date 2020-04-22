//
//  SearchServiceSorterTest.swift
//  GithubSearchTests
//
//  Created by Jure Čular on 22/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

import XCTest

class SearchServiceSorterTest: XCTestCase {
    private var _searchServiceInterface: SearchServiceInterface?
    
    override func setUp() {
        let owner = Owner(name: "OwnerMock")
        let repositories = [
            Repository(name: "Name1", owner: owner, description: "Description", lastUpdateTime: "2020-04-11T06:05:43Z"),
            Repository(name: "Name2", owner: owner, description: "Description", lastUpdateTime: "2020-02-14T09:31:03Z"),
        ]
        
        _searchServiceInterface = MockSearchService(repositoies: repositories)
    }

    func testSorting() {
        // Setup
        let expectation = XCTestExpectation(description: "Failed retrieving repositories")
        let mockDelegate = MockSearchServiceDelegate(successfullCallback: { (repositories) in
            XCTAssert(repositories.first?.name == "Name1")
            expectation.fulfill()
        }, errorCallback: { (error) in
            XCTFail(error.localizedDescription)
        })
        _searchServiceInterface?.delegate = mockDelegate
        let query = "a"
        
        // Test
        _searchServiceInterface?.searchRepositories(searchQuery: query)
        
         wait(for: [expectation], timeout: 5.0)
    }

}

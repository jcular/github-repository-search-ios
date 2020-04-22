//
//  MockSerachServiceDelegate.swift
//  GithubSearch
//
//  Created by Jure Čular on 22/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

import Foundation

class MockSearchServiceDelegate: SearchServiceDelegate {
    private let _successfullCallback: (([Repository]) -> Void)
    private let _errorCallback: ((Error) -> Void)
    
    init(successfullCallback: @escaping (([Repository]) -> Void), errorCallback: @escaping ((Error) -> Void)) {
        _successfullCallback = successfullCallback;
        _errorCallback = errorCallback;
    }
    
    func successfullyRetrieved(repositories: [Repository]) {
        _successfullCallback(repositories)
    }
    
    func failed(withError error: Error) {
        _errorCallback(error)
    }
}

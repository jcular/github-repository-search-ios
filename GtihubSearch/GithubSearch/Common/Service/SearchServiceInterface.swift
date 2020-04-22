//
//  SearchServiceInterface.swift
//  GtihubSearch
//
//  Created by Jure Čular on 21/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

protocol SearchServiceDelegate: AnyObject {
    func successfullyRetrieved(repositories: [Repository])
    func failed(withError error: Error)
}

protocol SearchServiceInterface {
    var delegate: SearchServiceDelegate? { get set }
    func searchRepositories(searchQuery query: String)
}

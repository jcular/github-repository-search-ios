//
//  SearchServiceInterface.swift
//  GtihubSearch
//
//  Created by Jure Čular on 21/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

import Foundation

protocol SearchServiceInterface {
    func searchRepositories(searchQuery query: String)
}

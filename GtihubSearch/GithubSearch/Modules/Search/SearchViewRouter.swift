//
//  SearchViewRouter.swift
//  GtihubSearch
//
//  Created by Jure Čular on 22/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//
import UIKit

enum SearchNavigationOption {
    case repositoryDetails(RepositoryDetails)
}

final class SearchViewRouter: BaseViewRouter {
    
    override init() {
        super.init()
        let searchService = SearchService()
        let viewController = SearchViewController(searchService: searchService, searchViewRouter: self)
        searchService.delegate = viewController
        temporaryViewController = viewController
    }

    func navigate(to option: SearchNavigationOption) {
        switch option {
        case .repositoryDetails(let repositoryDetails):
            _openRepositoryDetails(repositoryDetails: repositoryDetails)
        }
    }

    private func _openRepositoryDetails(repositoryDetails: RepositoryDetails) {
        let router = RepositoryDetailsViewRouter(repositoryDetails: repositoryDetails)
        navigationViewController?.push(viewRouter: router, animated: true)
    }
}

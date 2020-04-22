//
//  RepositoryDetailsViewRouter.swift
//  GithubSearch
//
//  Created by Jure Čular on 22/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//
import UIKit

final class RepositoryDetailsViewRouter: BaseViewRouter {
    
    init(repositoryDetails: RepositoryDetails) {
        super.init()
        let viewController = RepositoryDetailsViewController(repositoryDetails: repositoryDetails)
        temporaryViewController = viewController
    }
}

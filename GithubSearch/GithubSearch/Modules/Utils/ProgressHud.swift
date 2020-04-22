//
//  ProgressHud.swift
//  GithubSearch
//
//  Created by Jure Čular on 22/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

import UIKit

final class ProgressHudViewController: UIViewController {
    private let _activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.6)

        _activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        _activityIndicatorView.startAnimating()
        view.addSubview(_activityIndicatorView)

        NSLayoutConstraint.activate([
            _activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            _activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}


extension UIViewController {
    private static var _progressHud: ProgressHudViewController?
    
    func showProgressHud() {
        guard Self._progressHud == nil else {
            return
        }
        let progressHud = ProgressHudViewController()

        addChild(progressHud)
        progressHud.view.frame = view.frame
        view.addSubview(progressHud.view)
        progressHud.didMove(toParent: self)
        
        Self._progressHud = progressHud
    }
    
    func hideProgressHud() {
        guard let progressHud = Self._progressHud else {
            return
        }
        progressHud.willMove(toParent: nil)
        progressHud.view.removeFromSuperview()
        progressHud.removeFromParent()
        
        Self._progressHud = nil
    }
}

//
//  BaseViewRouter.swift
//  GtihubSearch
//
//  Created by Jure Čular on 22/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

import UIKit


protocol RouterInterface: class {
    func popFromNavigationController(animated: Bool)
    func dismiss(animated: Bool)

    func showErrorAlert(with message: String?)
}

class BaseViewRouter {
    var viewController : UIViewController {
        defer{ temporaryViewController = nil }
        return _viewController
    }
    
    private unowned var _viewController: UIViewController!
    var temporaryViewController: UIViewController? {
        didSet {
            guard let viewController = temporaryViewController else { return }
            _viewController = viewController
        }
    }
    
    private var _navigationViewController: UINavigationController? {
        get {
            return _viewController.navigationController
        }
    }
    
    
}

extension BaseViewRouter: RouterInterface {
    func popFromNavigationController(animated: Bool) {
        _navigationViewController?.popViewController(animated: animated)
    }
    
    func dismiss(animated: Bool) {
        _navigationViewController?.dismiss(animated: animated)
    }
    
    func showErrorAlert(with message: String?) {
        let alert = UIAlertController(title: NSLocalizedString("errorTitle", comment: ""), message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: nil)
        alert.addAction(okAction)
        _navigationViewController?.present(alert, animated: true, completion: nil)
    }
}


extension UIViewController {
    func present(viewRouter: BaseViewRouter, animated: Bool, completion: (() -> Void)?) {
        present(viewRouter.viewController, animated: animated, completion: completion)
    }

}

extension UINavigationController {
    func push(viewRouter: BaseViewRouter, animated: Bool) {
        self.pushViewController(viewRouter.viewController, animated: animated)
    }

    func setRoot(viewRouter: BaseViewRouter, animated: Bool) {
        self.setViewControllers([viewRouter.viewController], animated: animated)
    }

}

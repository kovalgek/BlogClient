//
//  LoginCoordinator.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 14/01/2023.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    var parentCoordinator: ChildRemoving?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, parentCoordinator: ChildRemoving) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let loginViewController = ViewControllerFactory.loginViewController
        loginViewController.coordinator = self
        navigationController.present(loginViewController, animated: true)
    }
}

extension LoginCoordinator: Dismissable {
    func dimiss(viewController: UIViewController) {
        viewController.dismiss(animated: true) {
            self.parentCoordinator?.remove(coordinator: self)
        }
    }
}

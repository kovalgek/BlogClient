//
//  LoginCoordinator.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 14/01/2023.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewController = ViewControllerFactory.loginViewController
        loginViewController.coordinator = self
        navigationController.present(loginViewController, animated: true)
    }
    
    func backToPosts() {
        navigationController.topViewController!.dismiss(animated: true) {
            
        }
    }
}

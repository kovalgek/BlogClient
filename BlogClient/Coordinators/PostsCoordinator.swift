//
//  MainCoordinator.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 14/01/2023.
//

import UIKit

class PostsCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let postsViewController = ViewControllerFactory.postsViewController
        postsViewController.coordinator = self
        navigationController.pushViewController(postsViewController, animated: true)
    }
    
    func presentLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }
    
    func showPost() {
        
    }
}

//
//  CreatePostCoordinator.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 18/01/2023.
//

import UIKit

class CreatePostCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var parentCoordinator: ChildRemoving?
    
    init(navigationController: UINavigationController, parentCoordinator: ChildRemoving) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let createPostViewController = ViewControllerFactory.createPostViewController()
        createPostViewController.coordinator = self
        navigationController.present(createPostViewController, animated: true)
    }
}

extension CreatePostCoordinator: Dismissable {
    func dimiss(viewController: UIViewController) {
        viewController.dismiss(animated: true) {
            self.parentCoordinator?.remove(coordinator: self)
        }
    }
}

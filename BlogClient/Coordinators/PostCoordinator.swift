//
//  PostCoordinator.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 18/01/2023.
//

import UIKit

class PostCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var parentCoordinator: ChildRemoving?
    let postID: UUID
    
    init(postID: UUID, navigationController: UINavigationController, parentCoordinator: ChildRemoving) {
        self.postID = postID
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let postViewController = ViewControllerFactory.postViewController(postID: postID)
        postViewController.coordinator = self
        navigationController.pushViewController(postViewController, animated: true)
    }
}

extension PostCoordinator: Popable {
    func goBack() {
        navigationController.popViewController(animated: true)
        parentCoordinator?.remove(coordinator: self)
    }
}

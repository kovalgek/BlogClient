//
//  MainCoordinator.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 14/01/2023.
//

import UIKit

protocol LoginPresenting: AnyObject {
    func presentLogin()
}

protocol PostShowing: AnyObject {
    func showPost(postID: UUID)
}

protocol PostCreating: AnyObject {
    func createPost()
}

class PostsCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var parentCoordinator: ChildRemoving?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let postsViewController = ViewControllerFactory.postsViewController
        postsViewController.coordinator = self
        navigationController.pushViewController(postsViewController, animated: true)
    }
}

extension PostsCoordinator: LoginPresenting {
    func presentLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController, parentCoordinator: self)
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }
}

extension PostsCoordinator: PostShowing {
    func showPost(postID: UUID) {
        let postCoordinator = PostCoordinator(postID: postID, navigationController: navigationController, parentCoordinator: self)
        childCoordinators.append(postCoordinator)
        postCoordinator.start()
    }
}

extension PostsCoordinator: PostCreating {
    func createPost() {
        let createPostCoordinator = CreatePostCoordinator(navigationController: navigationController, parentCoordinator: self)
        childCoordinators.append(createPostCoordinator)
        createPostCoordinator.start()
    }
}

extension PostsCoordinator: ChildRemoving {
    func remove(coordinator: Coordinator) {
        childCoordinators.removeLast()
    }
}

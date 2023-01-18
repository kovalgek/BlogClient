//
//  Coordinator.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 14/01/2023.
//

import UIKit

protocol Dismissable: AnyObject {
    func dimiss(viewController: UIViewController)
}

protocol Popable: AnyObject {
    func goBack()
}

protocol ChildRemoving {
    func remove(coordinator: Coordinator)
}

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var parentCoordinator: ChildRemoving? { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

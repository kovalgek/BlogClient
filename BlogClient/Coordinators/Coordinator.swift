//
//  Coordinator.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 14/01/2023.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

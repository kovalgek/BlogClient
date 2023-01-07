//
//  MainTabBarViewController.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 05/12/2021.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewControllers = [UINavigationController(rootViewController: postsViewController),
                                UINavigationController(rootViewController: usersViewController),
                                UINavigationController(rootViewController: categoriesViewController)]
    }
}

extension MainTabBarViewController {
    var postsViewController: PostsViewController {
        let postsViewController = PostsViewController()
        let postsBarItem = UITabBarItem(title: "Posts",
                                        image: UIImage(named: "defaultImage.png"),
                                        selectedImage: UIImage(named: "selectedImage.png"))
        postsViewController.tabBarItem = postsBarItem
        return postsViewController
    }

    var usersViewController: UsersViewController {
        let usersViewController = UsersViewController()
        let usersBarItem = UITabBarItem(title: "Users",
                                        image: UIImage(named: "defaultImage.png"),
                                        selectedImage: UIImage(named: "selectedImage.png"))
        usersViewController.tabBarItem = usersBarItem
        return usersViewController
    }

    var categoriesViewController: CategoriesViewController {
        let categoriesViewController = CategoriesViewController()
        let categoriesBarItem = UITabBarItem(title: "Categories",
                                             image: UIImage(named: "defaultImage.png"),
                                             selectedImage: UIImage(named: "selectedImage.png"))
        categoriesViewController.tabBarItem = categoriesBarItem
        return categoriesViewController
    }
}

//
//  ViewControllerFactory.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 14/01/2023.
//

import Foundation

class ViewControllerFactory {
    
    static var postsViewController: PostsViewController {
        let service = POPPostService()
        let viewModel = PostsViewModel(postService: service)
        return PostsViewController(viewModel: viewModel)
    }
    
    static var loginViewController: LoginViewController {
        let service = POPLoginService()
        let viewModel = LoginViewModel(loginService: service)
        return LoginViewController(viewModel: viewModel)
    }
}

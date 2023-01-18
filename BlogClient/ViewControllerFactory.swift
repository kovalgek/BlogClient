//
//  ViewControllerFactory.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 14/01/2023.
//

import Foundation

class ViewControllerFactory {
    
    static var postsViewController: PostsViewController {
        let service = PostsService()
        let viewModel = PostsViewModel(postsService: service)
        return PostsViewController(viewModel: viewModel)
    }
    
    static var loginViewController: LoginViewController {
        let service = LoginService()
        let viewModel = LoginViewModel(loginService: service)
        return LoginViewController(viewModel: viewModel)
    }
    
    static func postViewController(postID: UUID) -> PostViewController {
        let service = PostService()
        let viewModel = PostViewModel(service: service)
        return PostViewController(postID: postID, viewModel: viewModel)
    }
    
    static func createPostViewController() -> CreatePostViewController {
        let service = PostService()
        let viewModel = CreatePostViewModel(service: service)
        return CreatePostViewController(viewModel: viewModel)
    }
}

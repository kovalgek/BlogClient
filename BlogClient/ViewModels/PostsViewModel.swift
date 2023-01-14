//
//  PostsViewModel.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 14/01/2023.
//

import Foundation

protocol PostsViewModelProtocol {
    func loadPosts()
    var posts: Observable<[Post]> { get }
}

class PostsViewModel: PostsViewModelProtocol {
    
    private let postService: PostServicing
    
    init(postService: PostServicing) {
        self.postService = postService
    }
    
    func loadPosts() {
        Task(priority: .background) {
            let result = await postService.posts()
            switch result {
            case .success(let posts):
                self.posts.value = posts
            case .failure(let error):
                print(error)
            }
        }
    }
    
    var posts: Observable<[Post]> = Observable([])
}

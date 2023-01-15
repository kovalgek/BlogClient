//
//  PostViewModel.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 14/01/2023.
//

import Foundation

protocol PostViewModelProtocol {
    func loadPost(id: UUID)
    var post: Observable<Post?> { get }
}

class PostViewModel: PostViewModelProtocol {
    
    init(service: PostServicing) {
        self.service = service
    }
    
    private let service: PostServicing
    
    func loadPost(id: UUID) {
        service.loadPost(id: id) { result in
            switch result {
            case .success(let post):
                self.post.value = post
            case .failure(let error):
                print("error=\(error)")
            }
        }
    }
    
    var post: Observable<Post?> = Observable(nil)
}

//
//  CreatePostViewModel.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 15/01/2023.
//

import Foundation

protocol CreatePostViewModelProtocol {
    func createPost(title: String, content: String, userID: UUID)
}

class CreatePostViewModel: CreatePostViewModelProtocol {
    
    init(service: PostServicing) {
        self.service = service
    }
    
    private let service: PostServicing
    
    func createPost(title: String, content: String, userID: UUID) {
        service.createPost(title: title, content: content, userID: userID) { result in
            switch result {
            case .success(let post):
                break
            case .failure(let error):
                print(error)
            }
        }
    }
}

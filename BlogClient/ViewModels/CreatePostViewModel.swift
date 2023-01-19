//
//  CreatePostViewModel.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 15/01/2023.
//

import Foundation

enum CreatePostViewModelError: Error {
    case somethingWrong
}

protocol CreatePostViewModelProtocol {
    func createPost(title: String, content: String, completion: @escaping (CreatePostViewModelError?) -> Void)
}

class CreatePostViewModel: CreatePostViewModelProtocol {
    
    init(service: PostServicing) {
        self.service = service
    }
    
    private let service: PostServicing
    
    func createPost(title: String, content: String, completion: @escaping (CreatePostViewModelError?) -> Void) {
        service.createPost(title: title, content: content) { result in
            switch result {
            case .success:
                completion(nil)
            case .failure(let error):
                completion(error.viewModelError)
            }
        }
    }
}

extension PostError {
    var viewModelError: CreatePostViewModelError {
        .somethingWrong
    }
}

//
//  PostService.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 14/01/2023.
//

import Foundation

enum PostError: Error {
    case something
}

protocol PostServicing {
    func loadPost(id: UUID, completion: @escaping (Result<Post, PostError>) -> Void)
}

struct PostService: HTTPClient, PostServicing {
    func loadPost(id: UUID, completion: @escaping (Result<Post, PostError>) -> Void) {
        sendRequest(endpoint: PostEndpoint(postID: id)) { result in
            switch result {
            case .success(let post):
                completion(.success(post))
            case .failure(let error):
                completion(.failure(error.postError))
            }
        }
    }
}

extension RequestError {
    var postError: PostError {
        .something
    }
}

//
//  POPPostsService.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 07/01/2023.
//

import Foundation

protocol PostsServicing {
    func posts() async -> Result<[Post], RequestError>
}

struct PostsService: HTTPClient, PostsServicing {
    func posts() async -> Result<[Post], RequestError> {
        await sendRequest(endpoint: PostsEndpoint())
    }
}


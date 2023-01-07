//
//  POPPostService.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 07/01/2023.
//

import Foundation

protocol PostServicing {
    func posts() async -> Result<[Post], RequestError>
}

struct POPPostService: HTTPClient, PostServicing {
    func posts() async -> Result<[Post], RequestError> {
        return await sendRequest(endpoint: PostsEndpoint())
    }
}

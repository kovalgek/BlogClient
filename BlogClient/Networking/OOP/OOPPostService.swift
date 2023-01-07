//
//  Service.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 07/01/2023.
//

import Foundation

class Service {
    internal let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
}

class OOPPostService: Service, PostServicing {
    func posts() async -> Result<[Post], RequestError> {
        return await client.sendRequest(endpoint: PostsEndpoint())
    }
}

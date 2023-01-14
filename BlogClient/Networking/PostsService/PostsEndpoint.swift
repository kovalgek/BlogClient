//
//  PostEndpoint.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 06/01/2023.
//

import Foundation

struct PostsEndpoint: Endpoint {

    typealias Model = [Post]

    var path: String { "/api/posts" }
    var method: RequestMethod { .get }
    var header: [String: String]? {
        if let token = Auth.token {
            return ["Authorization": "Bearer \(token)"]
        }
        return nil
    }
    var body: [String: String]? { nil }
    
    
    func parse(data: Data) -> Result<Model, RequestError> {
        guard let posts = try? JSONDecoder().decode(Model.self, from: data) else {
            return .failure(.decode)
        }
        return .success(posts)
    }
}

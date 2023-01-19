//
//  CreatePostEndpoint.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 15/01/2023.
//

import Foundation

struct CreatePostEndpoint: Endpoint {
    typealias Model = Post

    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
    
    private let title: String
    private let content: String
    
    var path: String { "/api/posts/" }
    var method: RequestMethod { .post }
    var header: [String: String]? {
        if let token = Auth.token {
            return ["Content-Type" : "application/json",
                    "Authorization" : "Bearer \(token)"]
        }
        return nil
    }
    
    var body: [String: String]? {
        ["title"   : title,
         "content" : content]
    }
    
    func parse(data: Data) -> Result<Model, RequestError> {
        guard let posts = try? JSONDecoder().decode(Model.self, from: data) else {
            return .failure(.decode)
        }
        return .success(posts)
    }
}

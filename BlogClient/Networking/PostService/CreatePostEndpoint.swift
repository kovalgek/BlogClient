//
//  CreatePostEndpoint.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 15/01/2023.
//

import Foundation

struct CreatePostEndpoint: Endpoint {
    typealias Model = Post

    init(title: String, content: String, userID: UUID) {
        self.title = title
        self.content = content
        self.userID = userID
    }
    
    private let title: String
    private let content: String
    private let userID: UUID
    
    var path: String { "/api/posts/" }
    var method: RequestMethod { .post }
    var header: [String: String]? {
        if let token = Auth.token {
            return ["Authorization" : "Bearer \(token)"]
        }
        return nil
    }
    
    var body: [String: String]? {
        ["title"   : title,
         "content" : content,
         "userID"  : userID.uuidString]
    }
    
    func parse(data: Data) -> Result<Model, RequestError> {
        guard let posts = try? JSONDecoder().decode(Model.self, from: data) else {
            return .failure(.decode)
        }
        return .success(posts)
    }
}

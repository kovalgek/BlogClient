//
//  PostEndpoint.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 14/01/2023.
//

import Foundation

struct PostEndpoint: Endpoint {
    
    typealias Model = Post

    init(postID: UUID) {
        self.postID = postID
    }
    
    private let postID: UUID
    
    var path: String { "/api/posts/\(postID)" }
    var method: RequestMethod { .get }
    var header: [String: String]? { nil }
    var body: [String: String]? { nil }
    
    func parse(data: Data) -> Result<Model, RequestError> {
        guard let posts = try? JSONDecoder().decode(Model.self, from: data) else {
            return .failure(.decode)
        }
        return .success(posts)
    }
}

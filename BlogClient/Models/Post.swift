import Foundation


struct PostApiResponse {
    let posts: [Post]
}

extension PostApiResponse: Decodable {}

struct Post {
    let id: UUID
    let title: String
    let content: String
    let user: PostUser
}

extension Post: Codable {}

struct PostUser: Codable {
    let id: UUID
}

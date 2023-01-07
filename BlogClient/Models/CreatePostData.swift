
import Foundation

struct CreatePostData: Codable {
    let title: String
    let content: String
    let userID: UUID
}

extension Post {
//    func toCreateData() -> CreatePostData {
//        CreatePostData(title: self.title, content: self.content, userID: self.user.id)
//    }
}

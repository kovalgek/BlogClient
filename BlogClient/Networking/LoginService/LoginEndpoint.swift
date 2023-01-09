//
//  LoginEndpoint.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 08/01/2023.
//

import Foundation

struct LoginEndpoint: Endpoint {
    
    init(username: String, password: String) {
        loginString = "\(username):\(password)"
            .data(using: .utf8)?
           .base64EncodedString() ?? ""
    }
    private let loginString: String

    typealias Model = Token

    var path: String { "/api/users/login" }
    var method: RequestMethod { .post }
    var header: [String: String]? {
        ["Authorization" : "Basic \(loginString)"]
    }
    var body: [String: String]? { nil }
    
    
    func parse(data: Data) -> Result<Model, RequestError> {
        guard let posts = try? JSONDecoder().decode(Model.self, from: data) else {
            return .failure(.decode)
        }
        return .success(posts)
    }
}

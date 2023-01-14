//
//  POPLoginService.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 08/01/2023.
//

import Foundation

enum LoginResult {
    case success
    case failed
}

protocol LoginServicing {
    func login(username: String, password: String) async -> Result<Token, RequestError>
    func login(username: String, password: String, completion: @escaping (LoginResult) -> Void)
}

struct POPLoginService: HTTPClient, LoginServicing {
    
    func login(username: String, password: String) async -> Result<Token, RequestError> {
        await sendRequest(endpoint: LoginEndpoint(username: username, password: password))
    }
    
    func login(username: String, password: String, completion: @escaping (LoginResult) -> Void) {
        sendRequest(endpoint: LoginEndpoint(username: username, password: password)) { result in
            switch result {
            case .success:
                completion(.success)
            case .failure:
                completion(.failed)
            }
        }
    }
}

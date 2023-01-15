//
//  POPLoginService.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 08/01/2023.
//

import Foundation

enum LoginError: Error {
    case noUsername
    case wrongPassword
    case other
}

protocol LoginServicing {
    func login(username: String, password: String) async -> Result<Token, RequestError>
    func login(username: String, password: String, completion: @escaping (LoginError?) -> Void)
}

struct LoginService: HTTPClient, LoginServicing {
    
    func login(username: String, password: String) async -> Result<Token, RequestError> {
        await sendRequest(endpoint: LoginEndpoint(username: username, password: password))
    }
    
    func login(username: String, password: String, completion: @escaping (LoginError?) -> Void) {
        sendRequest(endpoint: LoginEndpoint(username: username, password: password)) { result in
            switch result {
            case .success:
                completion(nil)
            case .failure(let error):
                completion(error.loginError)
            }
        }
    }
}

extension RequestError {
    var loginError: LoginError {
        switch self {
        case .unauthorized:
            return .noUsername
        default:
            return .other
        }
    }
}

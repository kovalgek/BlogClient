//
//  LoginViewModel.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 14/01/2023.
//

import Foundation

enum LoginViewModelError: Error {
    case something
}

protocol LoginViewModelProtocol {
    func login(username: String, password: String,  completion: @escaping (LoginViewModelError?) -> Void)
}

class LoginViewModel: LoginViewModelProtocol {
    
    private let loginService: LoginServicing
    
    init(loginService: LoginServicing) {
        self.loginService = loginService
    }
    
    func login(username: String, password: String,  completion: @escaping (LoginViewModelError?) -> Void) {
        loginService.login(username: username, password: password) { error in
            if let error = error {
                completion(error.viewModelError)
            }
            completion(nil)
        }
    }
}

extension LoginError {
    var viewModelError: LoginViewModelError {
        return .something
    }
}

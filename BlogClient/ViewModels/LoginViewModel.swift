//
//  LoginViewModel.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 14/01/2023.
//

import Foundation

protocol LoginViewModelProtocol {
    func login(username: String, password: String,  completion: @escaping (LoginResult) -> Void)
}

class LoginViewModel: LoginViewModelProtocol {
    
    private let loginService: LoginServicing
    
    init(loginService: LoginServicing) {
        self.loginService = loginService
    }
    
    func login(username: String, password: String,  completion: @escaping (LoginResult) -> Void) {
        loginService.login(username: username, password: password) { _ in
            completion(.success)
        }
    }
}

//
//  POPLoginService.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 08/01/2023.
//

import Foundation

protocol LoginServicing {
    func login(username: String, password: String) async -> Result<Token, RequestError>
}

struct POPLoginService: HTTPClient, LoginServicing {
    func login(username: String, password: String) async -> Result<Token, RequestError> {
        // await sendRequest(endpoint: LoginEndpoint(username: username, password: password))
        await sendRequest(endpoint: LoginEndpoint(username: "admin", password: "password"))
        
        
    }
    
    
}

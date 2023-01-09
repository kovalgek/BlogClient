//
//  HTTPClient.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 06/01/2023.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T>(endpoint: T) async -> Result<T.Model, RequestError> where T: Endpoint
}

extension HTTPClient {
    func sendRequest<T>(endpoint: T) async -> Result<T.Model, RequestError> where T: Endpoint {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.port = endpoint.port
                
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                switch endpoint.parse(data: data) {
                case .success(let decodedResponse):
                    return .success(decodedResponse)
                case .failure:
                    return .failure(.decode)
                }
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}

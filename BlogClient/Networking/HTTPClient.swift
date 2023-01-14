//
//  HTTPClient.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 06/01/2023.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T>(endpoint: T) async -> Result<T.Model, RequestError> where T: Endpoint
    func sendRequest<T>(endpoint: T, completion: @escaping (Result<T.Model, RequestError>) -> Void) where T: Endpoint
}

extension HTTPClient {
    
    func request<T>(endpoint: T) -> URLRequest? where T: Endpoint {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.port = endpoint.port
                
        guard let url = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        return request
    }
    
    func sendRequest<T>(endpoint: T, completion: @escaping (Result<T.Model, RequestError>) -> Void) where T: Endpoint {

        guard let request = request(endpoint: endpoint) else {
            return completion(.failure(.invalidURL))
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.noResponse))
                return
            }
            switch response.statusCode {
            case 200...299:
                switch endpoint.parse(data: data) {
                case .success(let decodedResponse):
                    completion(.success(decodedResponse))
                case .failure:
                    completion(.failure(.decode))
                }
            case 401:
                completion(.failure(.unauthorized))
            default:
                completion(.failure(.unexpectedStatusCode))
            }
        }
        dataTask.resume()
    }

    
    func sendRequest<T>(endpoint: T) async -> Result<T.Model, RequestError> where T: Endpoint {
        
        guard let request = request(endpoint: endpoint) else {
            return .failure(.invalidURL)
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

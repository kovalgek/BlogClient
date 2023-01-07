//
//  Endpoint.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 06/01/2023.
//

import Foundation

enum RequestMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}

protocol Endpoint {
    associatedtype Model
    func parse(data: Data) -> Result<[Model], RequestError>
    
    var scheme: String { get }
    var host: String { get }
    var port: Int { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var scheme: String { "http" }
    var host: String { "localhost" }
    var port: Int { 8080 }
}

//enum Environment {
//    case debug
//    case prod
//}
//
//extension Endpoint {
//    var environment: Environment {
//        guard let env = UserDefaults.value(forKey: "env") as? String else {
//            return .debug
//        }
//        if env == "debug" {
//            return .debug
//        }
//        return .prod
//    }
//}

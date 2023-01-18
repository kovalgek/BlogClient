//
//  Token.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 08/01/2023.
//

import Foundation

struct Token: Decodable {
    var id: UUID?
    var value: String
    var userID: UUID
}

//
//  TokenEntity.swift
//  BCAppMovie
//
//  Created by Bruno Cardenas on 07/04/21.
//

import Foundation

struct TokenEntity: Codable {
    public let success: Bool?
    public let expires_at: String?
    public let request_token: String?
}

struct UserEntity: Codable {
    public let username: String?
    public let password: String?
    public let request_token: String?
}

//
//  User.swift
//  groupVote
//
//  Created by Alaa . on 05/08/2023.
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID?
    let name: String
}

struct UserInput: Codable {
    let name: String
}

struct UserResponse: Codable {
  let accessToken: String?
  let user: User
}



//
//  Group.swift
//  groupVote
//
//  Created by Alaa . on 05/08/2023.
//

import Foundation

struct Group: Identifiable, Codable {
    let id: UUID?
    let join_id: Int
    let type: String?
    let tie: Bool
    let close: Bool
    let end: Bool
}
// remove this
struct GroupInput: Codable {
    let type: String?
    let tie: Bool
    let close: Bool
    let end: Bool
}

struct JoinGroup: Codable {
    let join_id: Int
}

struct GroupResponse: Codable {
    let accessToken: String?
    let group: Group
}

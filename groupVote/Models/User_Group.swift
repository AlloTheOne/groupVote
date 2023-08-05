//
//  User_Group.swift
//  groupVote
//
//  Created by Alaa . on 05/08/2023.
//

import Foundation

struct User_Group: Identifiable, Codable {
    let id: UUID?
    let userID: User
    let group: Group
}

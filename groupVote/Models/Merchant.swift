//
//  Merchant.swift
//  groupVote
//
//  Created by Alaa . on 05/08/2023.
//

import Foundation

struct Merchant: Identifiable, Codable {
    let id: UUID?
//    let userID: User
//    let name: String
//    let votes: Int
}

struct MerchantResponse: Codable {
    let accessToken: String?
    let merchant: Merchant
}

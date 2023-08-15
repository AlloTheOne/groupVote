//
//  Merchant_Group.swift
//  groupVote
//
//  Created by Alaa . on 05/08/2023.
//

import Foundation


struct Merchant_Group: Identifiable, Codable {
    let id: UUID
    let merchant: Merchant
    let group: Group
}

struct BaseMerchant_Group: Codable {
    let id: UUID
    let merchant: BaseMerchant
    let group: Group
}

struct BaseMerchant: Codable {
    let id: UUID?
    let userID: User
    let name: String
    let votes: Int
}

//struct
struct MerchantInput: Codable {
    let name: String
}

struct Merchant_GroupResponse: Codable {
//    let accessToken: String?
    let merchant_group: Merchant_Group
}

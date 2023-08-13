//
//  Merchant_Group.swift
//  groupVote
//
//  Created by Alaa . on 05/08/2023.
//

import Foundation


struct Merchant_Group: Codable {
//    let id: UUID?
    let merchantID: UUID
    let groupID: UUID
}

struct MerchantInput: Codable {
    let name: String
}

struct Merchant_GroupResponse: Codable {
//    let accessToken: String?
    let merchant_group: Merchant_Group
}

//
//  Merchant_Group.swift
//  groupVote
//
//  Created by Alaa . on 05/08/2023.
//

import Foundation


struct Merchant_Group: Identifiable, Codable {
    let id: UUID?
    let merchantID: Merchant
    let groupID: Group
}

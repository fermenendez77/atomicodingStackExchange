//
//  Badge.swift
//  StackExchange
//
//  Created by Fernando Menendez on 05/06/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import Foundation

// MARK: - Item
struct Badge: Codable {
    let user: User
    let badgeType: String
    let awardCount: Int
    let rank: Badgetype
    let badgeID: Int
    let link: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case user
        case badgeType = "badge_type"
        case awardCount = "award_count"
        case rank
        case badgeID = "badge_id"
        case link, name
    }
}

struct BadgeCounts: Codable {
    let bronze, silver, gold: Int
}

enum Badgetype : String, Codable{
    case bronze, silver, gold
}

//
//  ApiResponseBadges.swift
//  StackExchange
//
//  Created by Fernando Menendez on 05/06/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import Foundation

struct APIResponseBadges: Codable {
    let items: [Badge]
    let hasMore: Bool
    let quotaMax, quotaRemaining: Int

    enum CodingKeys: String, CodingKey {
        case items
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
    }
}

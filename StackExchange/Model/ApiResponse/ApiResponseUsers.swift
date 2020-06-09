//
//  ApiResponseUsers.swift
//  StackExchange
//
//  Created by Fernando Menendez on 04/06/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import Foundation

struct APIResponseUsers: Codable {
    
    let users: [User]
    let hasMore: Bool
    let quotaMax, quotaRemaining: Int

    enum CodingKeys: String, CodingKey {
        case users = "items"
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
    }
}

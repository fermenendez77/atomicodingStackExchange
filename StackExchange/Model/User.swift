//
//  User.swift
//  StackExchange
//
//  Created by Fernando Menendez on 04/06/2020.
//  Copyright © 2020 Fernando Menendez. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let badgeCounts: BadgeCounts?
    let accountID: Int?
    let isEmployee: Bool?
    let lastModifiedDate, lastAccessDate, reputationChangeYear, reputationChangeQuarter: Int?
    let reputationChangeMonth, reputationChangeWeek, reputationChangeDay, reputation: Int?
    let creationDate: Int?
    let userType: UserType?
    let userID: Int?
    let acceptRate: Int?
    let location: String?
    let websiteURL: String?
    let link: String?
    let profileImage: String?
    let displayName: String?

    enum CodingKeys: String, CodingKey {
        case badgeCounts = "badge_counts"
        case accountID = "account_id"
        case isEmployee = "is_employee"
        case lastModifiedDate = "last_modified_date"
        case lastAccessDate = "last_access_date"
        case reputationChangeYear = "reputation_change_year"
        case reputationChangeQuarter = "reputation_change_quarter"
        case reputationChangeMonth = "reputation_change_month"
        case reputationChangeWeek = "reputation_change_week"
        case reputationChangeDay = "reputation_change_day"
        case reputation
        case creationDate = "creation_date"
        case userType = "user_type"
        case userID = "user_id"
        case acceptRate = "accept_rate"
        case location
        case websiteURL = "website_url"
        case link
        case profileImage = "profile_image"
        case displayName = "display_name"
    }
}

enum UserType: String, Codable {
    case registered = "registered"
}

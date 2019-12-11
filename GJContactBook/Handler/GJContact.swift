//
//  GJContact.swift
//  GJContactBook
//
//  Created by Mohit Jethwa on 11/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

import Foundation

struct GJContact: Codable, Comparable {
    static func < (lhs: GJContact, rhs: GJContact) -> Bool {
        return lhs.firstName > rhs.firstName
    }
    
    let id : Int
    let firstName: String
    let lastName: String
    let profilePic: String
    let favorite: Bool
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id, favorite, url
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePic = "profile_pic"
    }
}

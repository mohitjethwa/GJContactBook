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


class GJContactDetails: Codable {
    
    let id : Int
    let firstName: String
    let lastName: String
    let profilePic: String
    let favorite: Bool
    let email: String
    let phoneNumber: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, favorite,email
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePic = "profile_pic"
        case phoneNumber = "phone_number"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
}

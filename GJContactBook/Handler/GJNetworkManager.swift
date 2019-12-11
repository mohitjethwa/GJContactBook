//
//  GJNetworkManager.swift
//  GJContactBook
//
//  Created by Mohit Jethwa on 11/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

import Foundation

public enum GJNetworkManager : GJAPIRequest {
    
    case listApiRequest
    case contactDetails(url: String)
    case addContact(firstName: String, lastName: String, email: String, mobile: String)
    case updateContact(id: Int, firstName: String?, lastName: String?, email: String?, mobile: String?, isFavorite: Bool?)
    
    public var path: String {
        switch self {
        case .listApiRequest:
            return "http://gojek-contacts-app.herokuapp.com/contacts.json"
        case .addContact:
            return "http://gojek-contacts-app.herokuapp.com/contacts.json"
        case .updateContact(let id,_,_,_,_,_):
            return "http://gojek-contacts-app.herokuapp.com/contacts/\(id).json"
        case .contactDetails(let url):
            return url
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .listApiRequest,.contactDetails:
            return .get
        case .addContact:
            return .post
        case .updateContact:
            return .put
            
        }
        
    }
    
    public var headers: [String : String] {
        var headerData: [String: String] = [:]
        headerData["Content-Type"] = "application/json"
        headerData["Accept"] = "application/json"
        return headerData
    }
    
    public var params: Any? {
        
        switch self {
        case .addContact(let firstName, let lastName, let email, let mobile):
            var requestParams: [String: String] = [:]
            requestParams["first_name"] = firstName
            requestParams["last_name"] = lastName
            requestParams["email"] = email
            requestParams["phone_number"] = mobile
            return requestParams
            
        case .updateContact(_, let firstName, let lastName, let email, let mobile, let isFavorite):
            var requestParams: [String: Any] = [:]
            if let firstName = firstName {
                requestParams["first_name"] = firstName
            }
            if let lastName = lastName {
                requestParams["last_name"] = lastName
            }
            
            if let email = email {
                requestParams["email"] = email
            }
            if let mobile = mobile {
                requestParams["phone_number"] = mobile
            }
            
            if let mobile = mobile {
                requestParams["phone_number"] = mobile
            }
            if let isFavorite = isFavorite {
                requestParams["favorite"] = isFavorite
            }
            
            return requestParams
            
        default:
            return nil
        }
    }
    
}

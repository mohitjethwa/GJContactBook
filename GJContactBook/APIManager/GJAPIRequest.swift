//
//  GJAPIRequest.swift
//  GJContactBook
//
//  Created by Mohit Jethwa on 11/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Any?,_ response: URLResponse?,_ error: Error?)->()

public enum HTTPMethod : String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

public protocol GJAPIRequest {
    
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String] { get }
    var params: Any? {get}
    func request() -> URLRequest?
    
}

extension GJAPIRequest {
    
    public func request() -> URLRequest? {
        if let url = URL(string: self.path) {
            let request         = NSMutableURLRequest(url: url)
            request.httpMethod  = self.httpMethod.rawValue
            
            for hEntity in headers {
                request.setValue(hEntity.value, forHTTPHeaderField: hEntity.key)
            }
            
            if let params = params {
                request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
            }
            
            return request as URLRequest
        }
        return nil
        
    }
}

//
//  GJAPIService.swift
//  GJContactBook
//
//  Created by Mohit Jethwa on 11/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

import Foundation

public protocol GJAPIServices {
    @discardableResult
    func request<T: Codable>(type: T.Type?, _ route: GJAPIRequest, completion: @escaping NetworkRouterCompletion)  -> URLSessionDataTask?
}

public class GJAPIServicesHanlder: NSObject, GJAPIServices, URLSessionDelegate {
    
    private lazy var session: URLSession =  {
        URLSession.init(configuration: .default, delegate: self, delegateQueue: nil)
    }()
    public static var shared: GJAPIServicesHanlder = .init()
    private override init() {
        
    }
    /*
     * Method used to request API
     */
    @discardableResult
    public func request<T: Codable>(type: T.Type?, _ route: GJAPIRequest, completion: @escaping NetworkRouterCompletion)  -> URLSessionDataTask? {
        if let request = route.request() {
            let task = session.dataTask(with: request) {
                (data, response, error) in
                if let obj = data?.objectData(type: T.self) {
                    completion(obj.responseObject,response,obj.error)
                } else {
                    completion(nil, response,error)
                }
                
                
            }
            task.resume()
            return task
        }
        return nil
    }
}

extension Decodable {
    static func decode(with decoder: JSONDecoder = JSONDecoder(), from data: Data) throws -> Self {
        return try decoder.decode(Self.self, from: data)
    }
}


extension Data {
    
    func objectData<T:Codable>(type: T.Type?) -> (responseObject: Any?, error: Error?) {
        do {
            let responseObject = try T.self.decode(from: self)
            return (responseObject, nil)
        }
        catch let error {
            return (nil, error)
        }
    }
}

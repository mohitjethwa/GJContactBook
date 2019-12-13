//
//  MockAPIService.swift
//  GJContactBookTests
//
//  Created by Mohit Jethwa on 13/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

import Foundation

import Foundation
@testable import GJContactBook


class MockAPIService : GJAPIServices {
    let bundle  = Bundle.init(for: MockAPIService.self)
    func getSomeMockListAPIData() -> [GJContact] {
        let path = bundle.path(forResource: "GJContactListMockResponse", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
        return data.objectData(type: [GJContact].self).responseObject as! [GJContact]
        
    }
    func getSomeMockContactDetailsData() -> GJContactDetails {
        let path = bundle.path(forResource: "GJContactDetailsResponse", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
        return data.objectData(type: GJContactDetails.self).responseObject as! GJContactDetails
        
    }
    
    @discardableResult
    func request<T: Codable>(type: T.Type?, _ route: GJAPIRequest, completion: @escaping NetworkRouterCompletion) -> URLSessionDataTask? {
        if let route = route as? GJNetworkManager {
            switch route {
            case .listApiRequest:
                completion(self.getSomeMockListAPIData(),nil,nil)
            default:
                completion(self.getSomeMockContactDetailsData(),nil,nil)
            }
        }
        
        return nil
    }
}

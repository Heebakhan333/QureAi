//
//  APIEndpoint.swift
//  QureAi
//
//  Created by Heeba Khan on 20/05/24.
//

import Foundation
import Alamofire

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: Alamofire.HTTPMethod { get }
    var parameters: [String: Any]? { get }
    // Add other endpoint-specific properties as needed
}

enum APIEndpoint: Endpoint {
    var baseURL: String {
            return "https://platformapi.qure.ai"
        }
    
    case sendOtp(phoneNumber: String)
    case getUser(id: Int)
    
    var path: String {
           switch self {
           case .sendOtp:
               return "/accounts/phone_number/otp/send/"
           case .getUser(let id):
               return "/users/\(id)"
           // Add paths for other endpoints
           }
       }
    var method: Alamofire.HTTPMethod {
        switch self {
        case .sendOtp, .getUser:
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .sendOtp(let phoneNumber): // Add phoneNumber parameter to sendOtp case
            return ["phone_number": phoneNumber]
        case .getUser:
            return nil
        }
    }
}

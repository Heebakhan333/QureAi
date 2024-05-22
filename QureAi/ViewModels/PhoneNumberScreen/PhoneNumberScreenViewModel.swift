//
//  PhoneNumberScreenViewModel.swift
//  QureAi
//
//  Created by Heeba Khan on 22/05/24.
//

import Foundation


import Alamofire

typealias APICompletion = (Bool, Error?) -> Void

class PhoneNumberViewModel {
    
    var apiCompletion: APICompletion?
    let headers: HTTPHeaders = [
      //  "Authorization": "Bearer 644e806c-bf4d-4093-a22d-6d46a501965d",
        "Content-Type": "application/json"
    ]
    
    func sendPhoneNumberToAPI(_ phoneNumber: String) {
        let parameters: [String: Any] = ["phone_number": phoneNumber]
        
        AF.request("https://platformapi.qure.ai/accounts/phone_number/otp/send/",
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .response { response in
            if let statusCode = response.response?.statusCode {
                print("Response status code: \(statusCode)")
                
                if let errorCode = ErrorCode(rawValue: statusCode) {
                    // Handle error code using the ErrorCode enum
                    switch errorCode {
                    case .otpSent, .otpSuccess:
                        print("OTP Sent")
                        self.apiCompletion?(true, nil) // Trigger success
                    default:
                        // For other error codes, print the corresponding error message
                        print(errorCode.errorMessage)
                        self.apiCompletion?(false, nil) // Trigger failure
                    }
                } else {
                    // Handle unrecognized error codes
                    print("Unrecognized error code: \(statusCode)")
                    self.apiCompletion?(false, nil) // Trigger failure
                }
            } else {
                print("Invalid response")
                self.apiCompletion?(false, response.error) // Trigger failure
            }
        }
    }
}

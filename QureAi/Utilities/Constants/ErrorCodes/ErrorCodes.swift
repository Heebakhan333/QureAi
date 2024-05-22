//
//  ErrorCodes.swift
//  QureAi
//
//  Created by Heeba Khan on 22/05/24.
//

import Foundation

enum ErrorCode: Int {
    case otpSent, otpSuccess = 200
    case noPhoneNumberProvided = 400
    case noAccountFound = 403
    case otpRequestsTooQuickly = 429
    case internalServerError = 500
    case noOTPValidatorConfigured = 501
    
    
    var errorMessage: String {
        switch self {
        case .otpSent:
            return "OTP Sent"
        case .otpSuccess:
            return "OTP Success"
        case .noPhoneNumberProvided:
            return "No phone number was provided in the POST call"
        case .noAccountFound:
            return "No account found with the given phone number"
        case .otpRequestsTooQuickly:
            return "OTP requests too quickly"
        case .internalServerError:
            return "Internal server error"
        case .noOTPValidatorConfigured:
            return "No OTP Validator configured from the backend"
        }
    }
}

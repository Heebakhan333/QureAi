//
//  NetworkManager.swift
//  QureAi
//
//  Created by Heeba Khan on 20/05/24.
//

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    let headers: HTTPHeaders = [
        "Authorization": "Bearer 644e806c-bf4d-4093-a22d-6d46a501965d",
        "Content-Type": "application/json"
    ]

    
    private init() {}
    
    func request<T: Codable>(endpoint: APIEndpoint, completion: @escaping (Result<T,Error>) -> Void) {
        AF.request(endpoint.path, method: endpoint.method, parameters: endpoint.parameters)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func requestOtp(endpoint: APIEndpoint, completion: @escaping (Result<Void, Error>) -> Void) {
        AF.request("https://platformapi.qure.ai/accounts/phone_number/otp/send/", method: endpoint.method, parameters: endpoint.parameters, headers: headers)
            .validate()
            .response { response in
                if let error = response.error {
                    completion(.failure(error))
                } else if let statusCode = response.response?.statusCode {
                    if (200..<300).contains(statusCode) {
                        // Status code indicates success
                        print("Response status code: \(statusCode)")
                        completion(.success(()))
                    } else {
                        // Status code indicates failure
                        let error = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "API request failed with status code \(statusCode)"])
                        completion(.failure(error))
                    }
                } else {
                    // Unknown error
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"])
                    completion(.failure(error))
                }
            }
    }
    
}


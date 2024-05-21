//
//  NetworkManager.swift
//  QureAi
//
//  Created by Heeba Khan on 20/05/24.
//

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T: Codable>(endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
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
}

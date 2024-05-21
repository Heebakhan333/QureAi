//
//  DataParser.swift
//  QureAi
//
//  Created by Heeba Khan on 20/05/24.
//

import Foundation
class DataParser {
    
    // MARK: - JSON Parsing
    
    static func parseJSON<T: Decodable>(data: Data) throws -> T {
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw error
        }
    }
    
    // MARK: - XML Parsing
    
    // Add methods for parsing XML data if needed
    
    // MARK: - Plain Text Parsing
    
    static func parsePlainText(data: Data) -> String? {
        return String(data: data, encoding: .utf8)
    }
}

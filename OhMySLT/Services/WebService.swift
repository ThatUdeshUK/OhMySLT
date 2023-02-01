//
//  WebService.swift
//  OhMySLT
//
//  Created by 27k on 2023-01-09.
//

import Foundation

// MARK: NetworkError
enum NetworkError: Error {
    case invalidResponse
}

enum ConfigError: Error {
    case invalidSubscriberID
    case invalidAccessToken
    case invalidResfreshToken
}

// MARK: WebService
class WebService {
    
    private func querySLT(url: URL, authToken: String, clientId: String) async throws -> Data {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer " + authToken, forHTTPHeaderField: "Authorization")
        request.setValue(clientId, forHTTPHeaderField: "X-IBM-Client-Id")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        if httpResponse.statusCode == 401 {
            throw ConfigError.invalidAccessToken
        } else if httpResponse.statusCode != 200 {
            throw NetworkError.invalidResponse
        }
        
        return data
    }
    
    func getUsage(url: URL, authToken: String, clientId: String) async throws -> Usage {
        let response = try await querySLT(url: url, authToken: authToken, clientId: clientId)
        return try JSONDecoder().decode(Usage.self, from: response)
    }
    
    func getVASUsage(url: URL, authToken: String, clientId: String) async throws -> VASUsage {
        let response = try await querySLT(url: url, authToken: authToken, clientId: clientId)
        
        return try JSONDecoder().decode(VASUsage.self, from: response)
    }
    
}

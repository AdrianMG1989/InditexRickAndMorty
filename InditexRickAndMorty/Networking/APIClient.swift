//
//  APIClient.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 3/6/25.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case statusCode(Int)
    case decodingError(Error)
    case networkError(Error)
}

func performRequest<T: Decodable>(
    with request: URLRequest,
    decodeTo type: T.Type
) async throws -> T {
    do {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.statusCode(httpResponse.statusCode)
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw APIError.decodingError(error)
        }
        
    } catch {
        throw APIError.networkError(error)
    }
}

//
//  CharacterService.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 28/3/25.
//
import Foundation

protocol CharacterServiceProtocol{
    func fetchCharacters(page: Int, name: String?, status: String?) async throws -> CharacterResponse
}

final class CharacterService: CharacterServiceProtocol {
    
    private let configuration: ConfigurationProtocol
    
    init(configuration: ConfigurationProtocol = Configuration()) {
        self.configuration = configuration
    }
    
    func buildCharactersURLRequest(page: Int, name: String? = nil, status: String? = nil) throws -> URLRequest {
        
        let characterURL = configuration.urlBase + "character"
        var urlComponents = URLComponents(string: characterURL)
        
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "page", value: String(page))
        ]
        
        let optionalParams: [String: String?] = [
            "name": name,
            "status": status
        ]
        
        // Only no empty params
        queryItems += optionalParams.compactMap { key, value in
            guard let value = value, !value.isEmpty else { return nil }
            return URLQueryItem(name: key, value: value)
        }
        
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            throw URLError(.badURL)
        }
        
        return URLRequest(url: url)
    }
    
    func fetchCharacters(page: Int, name: String? = nil, status: String? = nil) async throws -> CharacterResponse {
        
        let urlRequest = try buildCharactersURLRequest(page: page, name: name, status: status)
        
        do {
            let responseDTO = try await performRequest(with: urlRequest, decodeTo: CharacterResponseDTO.self)
            return responseDTO.toDomain()
        } catch APIError.notFound {
            return CharacterResponse.empty
        }
    }
    
}


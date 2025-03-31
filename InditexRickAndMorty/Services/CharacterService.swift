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

class CharacterService: CharacterServiceProtocol {
    
    static let shared = CharacterService()
    private let configuration: ConfigurationProtocol
    
    private init(configuration: ConfigurationProtocol = Configuration()) {
        self.configuration = configuration
    }
    
    func fetchCharacters(page: Int, name: String? = nil, status: String? = nil) async throws -> CharacterResponse {
        
        let characterURL = configuration.urlBase + ("character")
        var urlComponents = URLComponents(string: characterURL)
        var queryItems: [URLQueryItem] = []
        
        queryItems.append(URLQueryItem(name: "page", value: String(page)))
        
        queryItems += ["name": name, "status": status]
            .compactMap { key, value in value?.isEmpty == false ? URLQueryItem(name: key, value: value) : nil }
        
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        switch httpResponse.statusCode {
        case 200:
            break
        case 404:
            throw CharacterServiceError.noCharactersFound
        case 500:
            throw CharacterServiceError.serverError
        default:
            throw CharacterServiceError.badResponse
        }
        
        do{
            let decodeResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
            return decodeResponse
        }catch{
            throw CharacterServiceError.decodingError
        }
        
    }
}

enum CharacterServiceError: Error {
    case noCharactersFound
    case serverError
    case invalidURL
    case badResponse
    case decodingError
    case unknownError
}


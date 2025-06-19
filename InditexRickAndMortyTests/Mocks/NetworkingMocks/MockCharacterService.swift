//
//  MockCharacterService.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 19/6/25.
//

@testable import InditexRickAndMorty

final class MockCharacterService: CharacterServiceProtocol {
    enum MockResult {
        case success(CharacterResponse)
        case failure(Error)
    }
    
    var result: MockResult
    
    init(result: MockResult) {
        self.result = result
    }
    
    func fetchCharacters(page: Int, name: String?, status: String?) async throws -> CharacterResponse {
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
}


//
//  MockFetchCharactersUseCase.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 30/3/25.
//

import XCTest
@testable import InditexRickAndMorty

class MockFetchCharactersUseCase: FetchCharactersUseCaseProtocol {
    
    func fetchCharactersWith(page: Int, name: String?, status: String?) async throws -> CharacterResponse {
        
        return mockCharacterResponse
    }
}

class MockFetchCharactersUseCaseWithError: FetchCharactersUseCaseProtocol {
    
    func fetchCharactersWith(page: Int, name: String?, status: String?) async throws -> CharacterResponse {
 
        throw CharacterServiceError.noCharactersFound
    }
}

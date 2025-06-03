//
//  FetchCharactersUseCase.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 28/3/25.
//

import Foundation

protocol FetchCharactersUseCaseProtocol{
    func fetchCharactersWith(page: Int, name: String?, status: String?) async throws -> CharacterResponse
}

struct FetchCharactersUseCase: FetchCharactersUseCaseProtocol{
    
    private let characterService: CharacterServiceProtocol

    init(characterService: CharacterServiceProtocol) {
        self.characterService = characterService
    }
    
    func fetchCharactersWith(page: Int, name: String?, status: String?) async throws -> CharacterResponse{
        try await characterService.fetchCharacters(page: page, name: name, status: status)
    }
}

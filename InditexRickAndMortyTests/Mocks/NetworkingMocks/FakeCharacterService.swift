//
//  FakeCharacterService.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 24/6/25.
//

@testable import InditexRickAndMorty

final class FakeCharacterService: CharacterServiceProtocol {
    
    var stubbedResponse: CharacterResponse
    private(set) var fetchCallCount = 0
    private(set) var lastParams: (page: Int, name: String?, status: String?)?
    
    init(stubbedResponse: CharacterResponse) {
        self.stubbedResponse = stubbedResponse
    }
    
    func fetchCharacters(page: Int, name: String?, status: String?) async throws -> CharacterResponse {
        fetchCallCount += 1
        lastParams = (page, name, status)
        return stubbedResponse
    }
}

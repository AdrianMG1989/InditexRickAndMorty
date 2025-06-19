//
//  MockFetchCharactersUseCase.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 19/6/25.
//

@testable import InditexRickAndMorty

final class MockFetchCharactersUseCase: FetchCharactersUseCaseProtocol {
    
    enum MockResult {
        case success(CharacterResponse)
        case failure(Error)
    }
    
    var result: MockResult
    var callCount = 0
    
    init(result: MockResult) {
        self.result = result
    }
    
    func fetchCharactersWith(page: Int, name: String?, status: String?) async throws -> CharacterResponse {
        callCount += 1
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
}

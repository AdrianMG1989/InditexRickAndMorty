//
//  FetchCharactersUseCaseTests.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 19/6/25.
//

import XCTest
@testable import InditexRickAndMorty

final class FetchCharactersUseCaseTests: XCTestCase {
    
    func testFetchCharactersSuccess() async throws {
        let expectedResponse = CharacterResponse.empty
        let service = MockCharacterService(result: .success(expectedResponse))
        let useCase = FetchCharactersUseCase(characterService: service)
        
        let response = try await useCase.fetchCharactersWith(page: 1, name: nil, status: nil)
        XCTAssertEqual(response.info.pages, expectedResponse.info.pages)
        XCTAssertEqual(response.results.count, expectedResponse.results.count)
    }
    
    func testFetchCharactersFailure() async {
        let service = MockCharacterService(result: .failure(APIError.notFound))
        let useCase = FetchCharactersUseCase(characterService: service)
        
        do {
            _ = try await useCase.fetchCharactersWith(page: 1, name: nil, status: nil)
            XCTFail("Expected to throw error")
        } catch {
            XCTAssertTrue(error is APIError)
        }
    }
}

//
//  HomeViewModelIntegrationTests.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 24/6/25.
//

import XCTest
@testable import InditexRickAndMorty

@MainActor
final class HomeViewModelIntegrationTests: XCTestCase {

    func test_fetchCharacters_success_populatesCharacters() async {
        // GIVEN
        let character = Character(
            id: 1,
            name: "Rick Sanchez",
            status: .alive,
            species: "Human",
            gender: "Male",
            origin: Location(name: "Earth (C-137)"),
            location: Location(name: "Citadel of Ricks"),
            imageUrl: "https://example.com/image.png"
        )

        let response = CharacterResponse(
            info: CharacterInfo(pages: 1),
            results: [character]
        )

        let fakeService = FakeCharacterService(stubbedResponse: response)
        let useCase = FetchCharactersUseCase(characterService: fakeService)
        let viewModel = HomeViewModel(fetchCharactersUseCase: useCase)

        // WHEN
        await viewModel.fetchCharacters(isNewSearch: true)

        // THEN
        XCTAssertEqual(viewModel.characters.count, 1)
        XCTAssertEqual(viewModel.characters.first?.name, "Rick Sanchez")
        XCTAssertEqual(viewModel.characters.first?.status, .alive)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(fakeService.fetchCallCount, 1)
        XCTAssertEqual(fakeService.lastParams?.page, 1)
    }
}

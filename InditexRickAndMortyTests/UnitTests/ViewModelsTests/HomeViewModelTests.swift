//
//  HomeViewModelTests.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 30/3/25.
//

import XCTest
@testable import InditexRickAndMorty

@MainActor
final class HomeViewModelTests: XCTestCase {

    // MARK: - Helpers

    private func makeViewModel(result: MockFetchCharactersUseCase.MockResult) -> HomeViewModel {
        let useCase = MockFetchCharactersUseCase(result: result)
        let viewModel = HomeViewModel(fetchCharactersUseCase: useCase)
        return viewModel
    }
    
    private func waitForAsync() async {
        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5s
    }

    // MARK: - LoadInitialData Tests

    func test_loadInitialData_success() async {
        let viewModel = makeViewModel(result: .success(MockCharacterResponse.basic))
        await waitForAsync()
        XCTAssertEqual(viewModel.characters.count, 3)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isFetchingPage)
        XCTAssertNil(viewModel.errorMessage)
    }

    func test_loadInitialData_failure() async {
        let error = NSError(domain: "", code: 123, userInfo: nil)
        let viewModel = makeViewModel(result: .failure(error))
        await waitForAsync()
        XCTAssertTrue(viewModel.characters.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isFetchingPage)
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    // MARK: - updateSearchText Tests
    
    func test_updateSearchText_callsFetchCharacters_whenSearchTextIsValid() async {
        let viewModel = makeViewModel(result: .success(MockCharacterResponse.basic))
        viewModel.searchText = "Rick" // >= minimumSearchLength
        
        viewModel.updateSearchText()
        
        await waitForAsync()
        
        XCTAssertEqual(viewModel.characters.count, MockCharacterResponse.basic.results.count)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isFetchingPage)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func test_updateSearchText_callsReturn_whenSearchTextIsNotValid() async {
        let viewModel = makeViewModel(result: .success(MockCharacterResponse.basic))
        viewModel.searchText = "Ri"
        
        viewModel.updateSearchText()
        
        await waitForAsync()
        
        XCTAssertEqual(viewModel.characters.count, MockCharacterResponse.basic.results.count)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isFetchingPage)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func test_updateSearchText_callsReturn_whenIsFetchingPageIsNotValid() async {
        let viewModel = makeViewModel(result: .success(MockCharacterResponse.basic))
        viewModel.searchText = "Rick"
        viewModel.isFetchingPage = true
        
        viewModel.updateSearchText()
        
        await waitForAsync()
        
        XCTAssertEqual(viewModel.characters.count, 0)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.isFetchingPage)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    // MARK: - updateFilter Tests
    
    func test_updateFilter_resetsCharactersAndFetchesNew() async {

        let viewModel = makeViewModel(result: .success(MockCharacterResponse.basic))
        viewModel.selectedStatus = .alive
        
        viewModel.updateFilter()
        await waitForAsync()

        XCTAssertEqual(viewModel.characters.count, MockCharacterResponse.basic.results.count)
        XCTAssertEqual(viewModel.characters.first?.name, "Rick Sanchez")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isFetchingPage)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func test_updateFilter_handlesEmptyResults() async {
        
        let viewModel = makeViewModel(result: .success(MockCharacterResponse.empty))

        
        viewModel.updateFilter()
        await waitForAsync()

        XCTAssertEqual(viewModel.characters.count, 0)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isFetchingPage)
        XCTAssertNil(viewModel.errorMessage)
    }

    // MARK: - loadMoreIfNeeded Tests
    
    func test_loadMoreIfNeeded_doesNothing_whenNotLastCharacter() async {
        let viewModel = makeViewModel(result: .success(MockCharacterResponse.basic))
        let characters = MockCharacterResponse.basic.results
        viewModel.characters = characters

        viewModel.loadMoreIfNeeded(currentCharacter: characters.first!)
        await waitForAsync()

        XCTAssertEqual(viewModel.characters.count, MockCharacterResponse.basic.results.count)
        XCTAssertEqual(viewModel.characters.first?.name, "Rick Sanchez")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isFetchingPage)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func test_loadMoreIfNeeded_triggersFetch_whenLastCharacter() async {
        
        let mock = MockFetchCharactersUseCase(result: .success(MockCharacterResponse.basic))
        let viewModel = HomeViewModel(fetchCharactersUseCase: mock)
        let characters = MockCharacterResponse.basic.results
        viewModel.characters = characters
        
        
        viewModel.loadMoreIfNeeded(currentCharacter: characters.last!)
        await waitForAsync()
        
        
        XCTAssertEqual(mock.callCount, 1)
    }
    
    // MARK: - characterTapped Tests
    
    func test_characterTapped_triggersOnCharacterSelected() {
        
        let character = mockCharacter1
        let viewModel = makeViewModel(result: .success(MockCharacterResponse.basic))

        var selectedCharacter: Character?
        viewModel.onCharacterSelected = { character in
            selectedCharacter = character
        }

        viewModel.characterTapped(character)

        XCTAssertEqual(selectedCharacter?.id, character.id)
        XCTAssertEqual(selectedCharacter?.name, character.name)
    }
    
    // MARK: - dismissError Tests
    
    func test_dismissError_setsErrorMessageToNil() {
        
        let viewModel = makeViewModel(result: .success(MockCharacterResponse.basic))
        viewModel.errorMessage = "Something went wrong"
        
        viewModel.dismissError()
        
        XCTAssertNil(viewModel.errorMessage)
    }
}


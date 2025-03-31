//
//  HomeViewModelTests.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 30/3/25.
//

import XCTest
@testable import InditexRickAndMorty

@MainActor
class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var mockFetchCharactersUseCase: MockFetchCharactersUseCase!
    var mockFetchCharactersUseCaseWithError: MockFetchCharactersUseCaseWithError!
    
    
    override func setUpWithError() throws {
        mockFetchCharactersUseCase = MockFetchCharactersUseCase()
        mockFetchCharactersUseCaseWithError = MockFetchCharactersUseCaseWithError()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockFetchCharactersUseCase = nil
        mockFetchCharactersUseCaseWithError = nil
    }
    
    // MARK: - Test resetSearch
    
    func testResetSearchResetsState() throws{
        
        // Given
        viewModel = HomeViewModel(fetchCharactersUseCase: mockFetchCharactersUseCase)
        viewModel.currentPage = 3
        viewModel.totalPages = 5
        
        // When
        viewModel.resetSearch()
        
        // Then
        XCTAssertEqual(viewModel.currentPage, 1)
        XCTAssertEqual(viewModel.totalPages, 1)
        XCTAssertTrue(viewModel.characters.isEmpty)
    }

    // MARK: - Test fetchFilteredCharacters
    
    func testFetchFilteredCharacters_SuccessfulFetch() async{
        // Given
        viewModel = HomeViewModel(fetchCharactersUseCase: mockFetchCharactersUseCase)
        
        // When
        await viewModel.fetchFilteredCharacters(isNewSearch: true)
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.characters.count, mockCharacterResponse.results.count)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.currentPage, 2)
        XCTAssertEqual(viewModel.totalPages, mockCharacterResponse.info.pages)
    }
    
    func testFetchFilteredCharacters_NoCharactersFound() async {
        // Given
        viewModel = HomeViewModel(fetchCharactersUseCase: mockFetchCharactersUseCaseWithError)
        
        // When
        await viewModel.fetchFilteredCharacters(isNewSearch: true)
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.currentPage, 1)
        XCTAssertEqual(viewModel.totalPages, 1)
        XCTAssertTrue(viewModel.characters.isEmpty)
    }
    
    func testFetchFilteredCharacters_PaginationContinues() async {
        // Given
        viewModel = HomeViewModel(fetchCharactersUseCase: mockFetchCharactersUseCase)
        viewModel.currentPage = 2
        viewModel.totalPages = 5
        let finalResultsCount = mockCharacterResponse.results.count + mockCharacterResponse.results.count
        
        // When
        let expectation = XCTestExpectation(description: "fetchFilteredCharacters completes")

        Task {
            XCTAssertTrue(viewModel.isLoading)
            await viewModel.fetchFilteredCharacters(isNewSearch: false)
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 2.0)

        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.characters.count, finalResultsCount)
        XCTAssertEqual(viewModel.currentPage, 3)
    }
    
    func testFetchFilteredCharacters_StopsWhenNoMorePages() async {
        // Given
        viewModel = HomeViewModel(fetchCharactersUseCase: mockFetchCharactersUseCase)
        viewModel.currentPage = 6
        viewModel.totalPages = 5
        
        // When
        await viewModel.fetchFilteredCharacters(isNewSearch: false)
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.currentPage, 6)
        XCTAssertEqual(viewModel.totalPages, 5)
    }
}

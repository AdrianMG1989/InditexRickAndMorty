//
//  CharacterResponseTests.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 19/6/25.
//

import XCTest
@testable import InditexRickAndMorty

final class CharacterResponseTests: XCTestCase {

    // MARK: - Test Initialization
    
    func testCharacterResponseInitialization() {
        let response = CharacterResponse(
            info: CharacterInfo(pages: 3),
            results: [mockCharacter1, mockCharacter2]
        )
        
        XCTAssertEqual(response.info.pages, 3)
        XCTAssertEqual(response.results.count, 2)
        XCTAssertEqual(response.results.first?.name, "Rick Sanchez")
    }

    // MARK: - Test Empty Static Instance
    
    func testEmptyCharacterResponse() {
        let emptyResponse = CharacterResponse.empty
        
        XCTAssertEqual(emptyResponse.info.pages, 0)
        XCTAssertTrue(emptyResponse.results.isEmpty)
    }

    // MARK: - Test CharacterInfo Initialization
    
    func testCharacterInfoInitialization() {
        let info = CharacterInfo(pages: 5)
        XCTAssertEqual(info.pages, 5)
    }
}

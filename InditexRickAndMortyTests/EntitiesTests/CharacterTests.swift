//
//  CharacterTests.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 30/3/25.
//

import XCTest
@testable import InditexRickAndMorty

class CharacterTests: XCTestCase {

    // MARK: - Test Initialization of Character

    func testCharacterInitialization() {
        
        let character = mockCharacter1
        
        XCTAssertEqual(character.id, 1)
        XCTAssertEqual(character.name, "Rick Sanchez")
        XCTAssertEqual(character.status, .alive)
        XCTAssertEqual(character.species, "Human")
        XCTAssertEqual(character.origin.name, "Earth")
        XCTAssertEqual(character.gender, "Male")
        XCTAssertEqual(character.location.name, "Citadel of Ricks")
        XCTAssertEqual(character.imageUrl, "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
    }
    
    // MARK: - Test Equatable for Character
    
    func testCharacterEquality() {
        
        let character1 = mockCharacter1
        let character2 = mockCharacter1
        
        XCTAssertTrue(character1 == character2)
    }

    func testCharacterInequality() {
        let character1 = mockCharacter1
        let character2 = mockCharacter2
        
        XCTAssertFalse(character1 == character2)
    }

    // MARK: - Test Location Equatable

    func testLocationEquality() {
        let location1 = mockLocation1
        let location2 = mockLocation1
        let location3 = mockLocation2
        
        XCTAssertTrue(location1 == location2)
        XCTAssertFalse(location1 == location3)
    }
}

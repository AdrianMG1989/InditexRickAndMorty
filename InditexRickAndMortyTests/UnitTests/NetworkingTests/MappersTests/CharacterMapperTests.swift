//
//  CharacterMapperTests.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 19/6/25.
//

import XCTest
@testable import InditexRickAndMorty

final class CharacterMapperTests: XCTestCase {
    
    func testToDomain_WithValidStatus() {
        let dto = CharacterDTO(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            gender: "Male",
            origin: LocationDTO(name: "Earth"),
            location: LocationDTO(name: "Citadel of Ricks"),
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
        )
        
        let domain = dto.toDomain()
        
        XCTAssertEqual(domain.id, 1)
        XCTAssertEqual(domain.status, .alive)
        XCTAssertEqual(domain.origin.name, "Earth")
        XCTAssertEqual(domain.imageUrl, dto.image)
    }
    
    func testToDomain_WithInvalidStatus_ShouldDefaultToUnknown() {
        let dto = CharacterDTO(
            id: 2,
            name: "Evil Rick",
            status: "InLimbo",
            species: "Robot",
            gender: "Male",
            origin: LocationDTO(name: "Unknown"),
            location: LocationDTO(name: "Void"),
            image: "https://rickandmortyapi.com/api/character/avatar/666.jpeg"
        )
        
        let domain = dto.toDomain()
        
        XCTAssertEqual(domain.status, .unknown)
    }
}

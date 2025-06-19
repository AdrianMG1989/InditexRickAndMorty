//
//  CharacterResponseMapperTests.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 19/6/25.
//

import XCTest
@testable import InditexRickAndMorty

final class CharacterResponseMapperTests: XCTestCase {
    
    func testToDomain_WithValidData() {
        let dto = CharacterResponseDTO(
            info: InfoDTO(pages: 3),
            results: [
                CharacterDTO(
                    id: 1,
                    name: "Rick Sanchez",
                    status: "Alive",
                    species: "Human",
                    gender: "Male",
                    origin: LocationDTO(name: "Earth"),
                    location: LocationDTO(name: "Citadel of Ricks"),
                    image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
                ),
                CharacterDTO(
                    id: 2,
                    name: "Morty Smith",
                    status: "Dead",
                    species: "Human",
                    gender: "Male",
                    origin: LocationDTO(name: "Earth"),
                    location: LocationDTO(name: "Earth"),
                    image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"
                )
            ]
        )
        
        let domain = dto.toDomain()
        
        XCTAssertEqual(domain.info.pages, 3)
        XCTAssertEqual(domain.results.count, 2)
        XCTAssertEqual(domain.results[0].name, "Rick Sanchez")
        XCTAssertEqual(domain.results[1].status, .dead)
    }
    
    func testToDomain_WithEmptyResults() {
        let dto = CharacterResponseDTO(
            info: InfoDTO(pages: 0),
            results: []
        )
        
        let domain = dto.toDomain()
        
        XCTAssertEqual(domain.info.pages, 0)
        XCTAssertTrue(domain.results.isEmpty)
    }
}

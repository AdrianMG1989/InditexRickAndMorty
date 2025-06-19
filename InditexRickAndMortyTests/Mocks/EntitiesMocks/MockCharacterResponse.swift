//
//  MockCharacterResponse.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 19/6/25.
//

@testable import InditexRickAndMorty

enum MockCharacterResponse {
    
    static let basic = CharacterResponse(
        info: CharacterInfo(pages: 5),
        results: [
            mockCharacter1,
            mockCharacter2,
            mockCharacter3
        ]
    )
    
    static let single = CharacterResponse(
        info: CharacterInfo(pages: 1),
        results: [mockCharacter1]
    )
    
    static let empty = CharacterResponse.empty
}

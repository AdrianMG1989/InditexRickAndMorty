//
//  Untitled.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 4/6/25.
//

struct CharacterResponse {
    let info: CharacterInfo
    let results: [Character]
    
    static let empty = CharacterResponse(info: CharacterInfo(pages: 0), results: [])
}

struct CharacterInfo {
    let pages: Int
}

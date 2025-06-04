//
//  CharacterResponse.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 3/6/25.
//

struct CharacterResponse: Decodable {
    let info: CharacterInfo
    let results: [CharacterDTO]
}

struct CharacterInfo: Decodable {
    let pages: Int
}

struct CharacterDTO: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let origin: LocationDTO
    let gender: String
    let location: LocationDTO
    let imageUrl: String
}

struct LocationDTO: Decodable {
    let name: String
}

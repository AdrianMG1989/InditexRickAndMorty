//
//  CharacterResponse.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 3/6/25.
//


struct CharacterResponseDTO: Decodable {
    let info: InfoDTO
    let results: [CharacterDTO]
}

struct InfoDTO: Decodable {
    let pages: Int
}

struct CharacterDTO: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: LocationDTO
    let location: LocationDTO
    let image: String
}

struct LocationDTO: Decodable {
    let name: String
}

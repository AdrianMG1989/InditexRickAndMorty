//
//  Character.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 28/3/25.
//

struct Character: Decodable, Identifiable, Equatable, Hashable{
    let id: Int
    let name: String
    let status: Status
    let species: String
    let origin: Location
    let gender: String
    let location: Location
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case origin
        case gender
        case location
        case imageUrl = "image"
    }
}

enum Status: String, CaseIterable, Decodable{
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

struct Location: Decodable, Equatable, Hashable {
    var name: String
}

struct CharacterInfo: Decodable {
    let pages: Int
}

struct CharacterResponse: Decodable {
    let info: CharacterInfo
    let results: [Character]
}



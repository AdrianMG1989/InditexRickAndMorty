//
//  MockData.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 30/3/25.
//

@testable import InditexRickAndMorty

let mockCharacter1 = Character(
    id: 1,
    name: "Rick Sanchez",
    status: .alive,
    species: "Human",
    gender: "Male", origin: Location(name: "Earth"),
    location: Location(name: "Citadel of Ricks"),
    imageUrl: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
)

let mockCharacter2 = Character(
    id: 2,
    name: "Morty Smith",
    status: .alive,
    species: "Human",
    gender: "Male", origin: Location(name: "unknown"),
    location: Location(name: "Citadel of Ricks"),
    imageUrl: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"
)

let mockCharacter3 = Character(
    id: 3,
    name: "Summer Smith",
    status: .dead,
    species: "Human",
    gender: "Female", origin: Location(name: "Earth (Replacement Dimension)"),
    location: Location(name: "Earth (Replacement Dimension)"),
    imageUrl: "https://rickandmortyapi.com/api/character/avatar/3.jpeg"
)


let mockLocation1 = Location(name: "Citadel of Ricks")

let mockLocation2 = Location(name: "Earth (Replacement Dimension)")

let mockStatus: [Status] = [.alive, .dead, .unknown]

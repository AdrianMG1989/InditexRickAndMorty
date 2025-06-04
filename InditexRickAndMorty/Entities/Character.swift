//
//  Character.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 28/3/25.
//

struct Character: Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let gender: String
    let origin: Location
    let location: Location
    let imageUrl: String
}

enum Status: String, CaseIterable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

struct Location: Equatable, Hashable {
    let name: String
}

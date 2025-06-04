//
//  CharacterMapper.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 3/6/25.
//

import Foundation

extension CharacterDTO {
    func toDomain() -> Character {
        Character(
            id: id,
            name: name,
            status: Status(rawValue: status) ?? .unknown,
            species: species,
            gender: gender,
            origin: Location(name: origin.name),
            location: Location(name: location.name),
            imageUrl: image
        )
    }
}

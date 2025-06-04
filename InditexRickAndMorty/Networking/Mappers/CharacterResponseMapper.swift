//
//  CharacterResponseMapper.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 4/6/25.
//

extension CharacterResponseDTO {
    func toDomain() -> CharacterResponse {
        return CharacterResponse(
            info: CharacterInfo(pages: info.pages),
            results: results.map { $0.toDomain() }
        )
    }
}

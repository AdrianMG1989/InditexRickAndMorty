//
//  UseCaseFactory.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 3/6/25.
//

import Foundation

protocol UseCaseFactoryProtocol {
    func makeFetchCharactersUseCase() -> FetchCharactersUseCaseProtocol
}

struct UseCaseFactory: UseCaseFactoryProtocol {
    private let configuration: ConfigurationProtocol

    init(configuration: ConfigurationProtocol = Configuration()) {
        self.configuration = configuration
    }

    func makeFetchCharactersUseCase() -> FetchCharactersUseCaseProtocol {
        let characterService = CharacterService(configuration: configuration)
        return FetchCharactersUseCase(characterService: characterService)
    }
}

//
//  ViewModelFactory.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 4/6/25.
//

protocol ViewModelFactoryProtocol {
    @MainActor func makeHomeViewModel(onCharacterSelected: @escaping (Character) -> Void) -> HomeViewModel
}

struct ViewModelFactory: ViewModelFactoryProtocol {
    private let useCaseFactory: UseCaseFactoryProtocol
    
    init(useCaseFactory: UseCaseFactoryProtocol) {
        self.useCaseFactory = useCaseFactory
    }

    @MainActor
    func makeHomeViewModel(onCharacterSelected: @escaping (Character) -> Void) -> HomeViewModel {
        let vm = HomeViewModel(fetchCharactersUseCase: useCaseFactory.makeFetchCharactersUseCase())
        vm.onCharacterSelected = onCharacterSelected
        return vm
    }
}

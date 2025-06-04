//
//  ViewModelFactory.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 4/6/25.
//

struct ViewModelFactory {
    private let useCaseFactory: UseCaseFactory
    
    init(useCaseFactory: UseCaseFactory) {
        self.useCaseFactory = useCaseFactory
    }

    @MainActor
    func makeHomeViewModel(onCharacterSelected: @escaping (Character) -> Void) -> HomeViewModel {
        let vm = HomeViewModel(fetchCharactersUseCase: useCaseFactory.makeFetchCharactersUseCase())
        vm.onCharacterSelected = onCharacterSelected
        return vm
    }
}

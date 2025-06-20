//
//  AppDIContainer.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 20/6/25.
//

@MainActor
final class AppDIContainer {
    let useCaseFactory: UseCaseFactoryProtocol
    let viewModelFactory: ViewModelFactoryProtocol
    let coordinator: Coordinator

    init() {
        self.useCaseFactory = UseCaseFactory()
        self.viewModelFactory = ViewModelFactory(useCaseFactory: useCaseFactory)
        self.coordinator = Coordinator(viewModelFactory: viewModelFactory)
    }
}

//
//  InditexRickAndMortyApp.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 28/3/25.
//

import SwiftUI

@main
struct InditexRickAndMortyApp: App {
    
    @StateObject private var router = DefaultRouter()
    let factory = UseCaseFactory()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                let viewModel = HomeViewModel(fetchCharactersUseCase: factory.makeFetchCharactersUseCase())
                HomeView(viewModel: viewModel)
                    .environmentObject(router)
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .characterDetail(let character):
                            CharacterDetailView(character: character)
                        }
                    }
            }
        }
    }
}

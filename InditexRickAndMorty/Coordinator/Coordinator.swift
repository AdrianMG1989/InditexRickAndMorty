//
//  Coordinator.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 22/5/25.
//

import SwiftUI

enum NavigationRoute: Hashable {
    case home
    case characterDetail(Character)
}

@MainActor
final class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    private let viewModelFactory: ViewModelFactory
    
    init(viewModelFactory: ViewModelFactory) {
        self.viewModelFactory = viewModelFactory
    }
    
    var pathBinding: Binding<NavigationPath> {
        Binding(
            get: { self.path },
            set: { self.path = $0 }
        )
    }
    
    func navigate(to route: NavigationRoute) {
        path.append(route)
    }

    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    @ViewBuilder
    func build(route: NavigationRoute) -> some View {
        switch route {
        case .home:
            let viewModel = viewModelFactory.makeHomeViewModel { [weak self] character in
                self?.navigate(to: .characterDetail(character))
            }
            HomeView(viewModel: viewModel)
            
        case .characterDetail(let character):
            CharacterDetailView(character: character)
        }
    }
}

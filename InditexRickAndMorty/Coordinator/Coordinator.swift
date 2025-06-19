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
protocol CoordinatorProtocol: ObservableObject {
    var pathBinding: Binding<NavigationPath> { get }
    func navigate(to route: NavigationRoute)
    func pop()
    func popToRoot()
    func build(route: NavigationRoute) -> AnyView
    func clearCache()
    func clearCache<T>(for type: T.Type)
}

@MainActor
final class Coordinator: CoordinatorProtocol {
    @Published var path = NavigationPath()
    
    private let viewModelFactory: ViewModelFactoryProtocol
    private var viewModelCache: [ObjectIdentifier: Any] = [:]
    
    init(viewModelFactory: ViewModelFactoryProtocol) {
        self.viewModelFactory = viewModelFactory
    }
    
    var pathBinding: Binding<NavigationPath> {
        Binding(get: { self.path }, set: { self.path = $0 })
    }
    
    func navigate(to route: NavigationRoute) {
        path.append(route)
    }

    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path.removeLast(path.count)
        clearCache()
    }

    func getCachedViewModel<T>(for type: T.Type, factory: () -> T) -> T {
        let key = ObjectIdentifier(type)
        if let cached = viewModelCache[key] as? T {
            return cached
        } else {
            let newVM = factory()
            viewModelCache[key] = newVM
            return newVM
        }
    }
    
    func clearCache() {
        viewModelCache.removeAll()
    }
    
    func clearCache<T>(for type: T.Type) {
        let key = ObjectIdentifier(type)
        viewModelCache.removeValue(forKey: key)
    }
    

    func build(route: NavigationRoute) -> AnyView {
        switch route {
        case .home:
            let viewModel: HomeViewModel = getCachedViewModel(for: HomeViewModel.self) {
                viewModelFactory.makeHomeViewModel { [weak self] character in
                    self?.navigate(to: .characterDetail(character))
                }
            }
            return AnyView(HomeView(viewModel: viewModel))

        case .characterDetail(let character):
            return AnyView(CharacterDetailView(character: character))
        }
    }
}

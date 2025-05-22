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
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                HomeView()
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

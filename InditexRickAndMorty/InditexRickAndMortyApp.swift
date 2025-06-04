//
//  InditexRickAndMortyApp.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 28/3/25.
//

import SwiftUI

@main
struct InditexRickAndMortyApp: App {
    
    var body: some Scene {
        WindowGroup {
            let useCaseFactory = UseCaseFactory()
            let viewModelFactory = ViewModelFactory(useCaseFactory: useCaseFactory)
            let coordinator = Coordinator(viewModelFactory: viewModelFactory)

            NavigationHostView(coordinator: coordinator)
        }
    }
}

//
//  NavigationHostView.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 4/6/25.
//

import SwiftUI

struct NavigationHostView: View {
    @ObservedObject var coordinator: Coordinator

    var body: some View {
        NavigationStack(path: coordinator.pathBinding) {
            coordinator.build(route: .home)
                .navigationDestination(for: NavigationRoute.self) { route in
                    coordinator.build(route: route)
                }
        }
    }
}

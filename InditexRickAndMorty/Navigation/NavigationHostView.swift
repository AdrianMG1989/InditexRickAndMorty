//
//  NavigationHostView.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 4/6/25.
//

import SwiftUI

struct NavigationHostView<CoordinatorType: CoordinatorProtocol>: View {
    @ObservedObject var coordinator: CoordinatorType

    var body: some View {
        NavigationStack(path: coordinator.pathBinding) {
            coordinator.build(route: .home)
                .navigationDestination(for: NavigationRoute.self) { route in
                    coordinator.build(route: route)
                }
        }
    }
}

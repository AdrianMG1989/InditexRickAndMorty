//
//  Router.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 22/5/25.
//

import Foundation

enum Route: Hashable {
    case characterDetail(Character)
}

protocol Router: ObservableObject{
    associatedtype Destination

    func navigate(to destination: Destination)
    func pop()
}

class DefaultRouter: Router {
    
    @Published var path: [Route] = []

    func navigate(to destination: Route) {
        path.append(destination)
    }

    func pop() {
        _ = path.popLast()
    }
}

//
//  MockConfiguration.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 19/6/25.
//

@testable import InditexRickAndMorty

struct MockConfiguration: ConfigurationProtocol {
    var urlBase: String { "https://api.test.com/" }
}

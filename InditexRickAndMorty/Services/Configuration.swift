//
//  Configuration.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 28/3/25.
//

import Foundation

protocol ConfigurationProtocol {
    var urlBase: String { get }
}

final class Configuration: ConfigurationProtocol {
    
    let urlBase: String = "https://rickandmortyapi.com/api/"
    
}

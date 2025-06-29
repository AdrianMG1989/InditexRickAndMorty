//
//  CharacterServiceTests.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 19/6/25.
//

import XCTest
@testable import InditexRickAndMorty

final class CharacterServiceTests: XCTestCase {
    
    func testBuildURLRequest_WithOnlyPage() throws {
        let config = MockConfiguration()
        let service = CharacterService(configuration: config)

        let request = try service.buildCharactersURLRequest(page: 1)
        
        XCTAssertEqual(request.url?.absoluteString, "https://api.test.com/character?page=1")
    }

    func testBuildURLRequest_WithPageAndName() throws {
        let config = MockConfiguration()
        let service = CharacterService(configuration: config)

        let request = try service.buildCharactersURLRequest(page: 2, name: "Rick")
        
        XCTAssertEqual(request.url?.absoluteString, "https://api.test.com/character?page=2&name=Rick")
    }

    func testBuildURLRequest_WithAllParams() throws {
        let config = MockConfiguration()
        let service = CharacterService(configuration: config)
        
        let request = try service.buildCharactersURLRequest(page: 3, name: "Morty", status: "alive")
        let url = try XCTUnwrap(request.url)
        let components = try XCTUnwrap(URLComponents(url: url, resolvingAgainstBaseURL: false))
        
        let expectedItems = [
            URLQueryItem(name: "page", value: "3"),
            URLQueryItem(name: "name", value: "Morty"),
            URLQueryItem(name: "status", value: "alive")
        ]
        
        for item in expectedItems {
            XCTAssertTrue(components.queryItems?.contains(item) == true)
        }
    }
}

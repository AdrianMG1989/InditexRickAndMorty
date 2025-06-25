//
//  FilterStatusTests.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 19/6/25.
//

import XCTest
@testable import InditexRickAndMorty

final class FilterStatusTests: XCTestCase {
    
    func testFilterStatusApiValue() {
        XCTAssertEqual(FilterStatus.all.apiValue, "")
        XCTAssertEqual(FilterStatus.alive.apiValue, "alive")
        XCTAssertEqual(FilterStatus.dead.apiValue, "dead")
        XCTAssertEqual(FilterStatus.unknown.apiValue, "unknown")
    }
}

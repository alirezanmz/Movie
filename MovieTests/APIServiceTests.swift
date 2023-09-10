//
//  APIServiceTests.swift
//  MovieTests
//
//  Created by Alireza Namazi on 9/10/23.
//

import Foundation
import XCTest

class APIServiceTests: XCTestCase {
    
    var mockAPIService: MockAPIService!

    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
    }

    override func tearDown() {
        mockAPIService = nil
        super.tearDown()
    }

    func testMockGetMoviesList() {
        mockAPIService.getMoviesList { (response) in
            XCTAssertNotNil(response, "No movies were fetched.")
            XCTAssertEqual(response.results.count, 10, "Expected 10 movies in the sample data.")
        }
    }

    func testMockGetFavoritesList() {
        mockAPIService.getFavoritesList { (response) in
            XCTAssertNotNil(response, "No favorites were fetched.")
            XCTAssertEqual(response.results.count, 5, "Expected 5 favorites in the sample data.")
        }
    }
}

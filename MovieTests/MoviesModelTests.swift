//
//  MovieTests.swift
//  MovieTests
//
//  Created by Alireza Namazi on 4/21/22.
//

import XCTest
@testable import Movie

class MoviesModelTests: XCTestCase {
    
    var moviesSampleData: Data!
    var favoriteSampleData: Data!

    override func setUp() {
        super.setUp()
        
        // Loading the sample Movies JSON data
        if let url = Bundle(for: MoviesModelTests.self).url(forResource: "MovieJson", withExtension: "json") {
            moviesSampleData = try? Data(contentsOf: url)
        }
        
        // Loading the sample Favorites JSON data
        if let url = Bundle(for: MoviesModelTests.self).url(forResource: "FavoriteJson", withExtension: "json") {
            favoriteSampleData = try? Data(contentsOf: url)
        }
    }

    override func tearDown() {
        moviesSampleData = nil
        favoriteSampleData = nil
        super.tearDown()
    }

    func testMoviesDecoding() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let moviesResponse = try decoder.decode(MoviesResponse.self, from: moviesSampleData)
            XCTAssertNotNil(moviesResponse, "Decoding MoviesResponse failed.")
            XCTAssertEqual(moviesResponse.results.count, 10, "Expected 10 movies in the sample data.")
        } catch {
            XCTFail("Error decoding the MoviesResponse: \(error)")
        }
    }

    func testFavoriteDecoding() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let favoriteResponse = try decoder.decode(FavoriteResponse.self, from: favoriteSampleData)
            XCTAssertNotNil(favoriteResponse, "Decoding FavoriteResponse failed.")
            XCTAssertEqual(favoriteResponse.results.count, 5, "Expected 5 favorites in the sample data.")
        } catch {
            XCTFail("Error decoding the FavoriteResponse: \(error)")
        }
    }
}

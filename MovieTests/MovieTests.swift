//
//  MovieTests.swift
//  MovieTests
//
//  Created by Alireza Namazi on 4/21/22.
//
import Alamofire
import XCTest
@testable import Movie

class MovieTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    
    func testFavoriteApi() throws {
        guard let url = URL(string: Constants.APIService.FavoriteMoviesList) else { return }
        AF.request(url, method: .get, parameters: nil).response { response in
            switch response.result {
            case .success:
                XCTAssertTrue(true)
            case .failure:
                XCTAssertTrue(false)
            }
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

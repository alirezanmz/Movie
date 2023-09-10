//
//  File.swift
//  MovieTests
//
//  Created by Alireza Namazi on 4/27/22.
//

import Foundation
import Alamofire
import ANActivityIndicator

class MockAPIService {
    
    func getMoviesList(completion: @escaping (MoviesResponse) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        if let url = Bundle(for: type(of: self)).url(forResource: "MovieJson", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let moviesResponse = try? decoder.decode(MoviesResponse.self, from: data) {
            completion(moviesResponse)
            
        }
    }
    
     func getFavoritesList(completion: @escaping (FavoriteResponse) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        if let url = Bundle(for: type(of: self)).url(forResource: "FavoriteJson", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let favoriteResponse = try? decoder.decode(FavoriteResponse.self, from: data) {
            completion(favoriteResponse)
        }
    }
}

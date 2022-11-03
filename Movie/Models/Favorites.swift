//
//  Favorites.swift
//  Movie
//
//  Created by Alireza Namazi on 4/26/22.
//

import Foundation
struct FavoriteResponse:Codable {
    let results:[Favorite]
    init(results: [Favorite]) {
        self.results = results
    }
}

struct Favorite:Codable {
    var id:Int?
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
    }
}

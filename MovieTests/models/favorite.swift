//
//  favorite.swift
//  MovieTests
//
//  Created by Alireza Namazi on 9/10/23.
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

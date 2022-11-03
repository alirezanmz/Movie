//
//  Movies.swift
//  Movie
//
//  Created by Alireza Namazi on 4/25/22.
//

import Foundation

struct MoviesResponse:Codable {
    let results:[Movies]
}


struct Movies:Codable {
    let backdrop_path:String?
    let id:Int?
    let original_language:String?
    let original_title:String?
    let overview:String?
    let popularity:Float?
    let poster_path:String?
    let release_date:String?
    let title:String?
    let rating:Float?
    let isWatched:Bool?
    var IsSelected:Bool?
    init(backdrop_path: String?, id: Int?, original_language: String?, original_title: String?, overview: String?, popularity: Float?, poster_path: String?, release_date: String?, title: String?, rating: Float?, isWatched: Bool?, IsSelected: Bool? = nil) {
        self.backdrop_path = backdrop_path
        self.id = id
        self.original_language = original_language
        self.original_title = original_title
        self.overview = overview
        self.popularity = popularity
        self.poster_path = poster_path
        self.release_date = release_date
        self.title = title
        self.rating = rating
        self.isWatched = isWatched
        self.IsSelected = IsSelected
    }
}

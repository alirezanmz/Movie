//
//  movies.swift
//  MovieTests
//
//  Created by Alireza Namazi on 9/10/23.
//

import Foundation

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
}

struct MoviesResponse:Codable {
    let results:[Movies]
}

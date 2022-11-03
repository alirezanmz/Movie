//
//  File.swift
//  MovieTests
//
//  Created by Alireza Namazi on 4/27/22.
//

import Foundation
import Alamofire
import ANActivityIndicator

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
}

struct FavoriteResponse:Codable {
    let results:[Favorite]
}

struct Favorite:Codable {
    var id:Int?
}

import UIKit
struct Constants {
    static let baseURL = "https://61efc467732d93001778e5ac.mockapi.io"
    static let retrievingImageURL = "https://image.tmdb.org/t/p/original/"
    struct APIService {
        static let MoviesList = Constants.baseURL + "/movies/list"
        static let FavoriteMoviesList = Constants.baseURL + "/movies/favorites"
        
    }
    struct CustomFont {
        static let Roboto_Regular: UIFont = UIFont(name: "Roboto-Regular", size: 20)!
        static let Roboto_Bold: UIFont = UIFont(name: "Roboto-Bold", size: 12)!
    }
    struct TextColor {
        static let libraryTitle: UIColor = UIColor.init(red: 90/255, green: 99/255, blue: 118/255, alpha: 1.0)
        static let LightGray = UIColor(red: 160/255, green: 179/255, blue: 194/255, alpha: 1)
        
    }
    struct BackgroundColor {
        static let Primary = UIColor(red: 10/255, green: 101/255, blue: 255/255, alpha: 1)
        static let Green = UIColor(red: 47/255, green: 168/255, blue: 79/255, alpha: 1)
        static let Red = UIColor(red: 234/255, green: 83/255, blue: 72/255, alpha: 1)
        static let Yellow = UIColor(red: 245/255, green: 189/255, blue: 23/255, alpha: 1)
        static let Alpha_Blue = UIColor(red: 10/255, green: 101/255, blue: 255/255, alpha: 1)
        static let Alpha_Blue_Items = UIColor(red: 113/255, green: 175/255, blue: 250/255, alpha: 0.52)
        static let Brown = UIColor(red: 139/255, green: 87/255, blue: 42/255, alpha: 1)
        static let LightGray = UIColor(red: 229/255, green: 228/255, blue: 229/255, alpha: 1)
    }
}

open class UnitTestService {
    func getMoviesList(completion: @escaping ((MoviesResponse?) -> Void)) {
        guard let url = Bundle(for: type(of: self)).path(forResource: "FavoriteJson", ofType: "json") else {
            fatalError("Didn't find it")
        }
        guard let json = try? String(contentsOfFile: url,encoding: .utf8) else {
            fatalError("Didn't find it")
        }
            let JSONDATA = json.data(using: .utf8)
            let jsonDecoder = JSONDecoder()
            let responseModel = try? jsonDecoder.decode(MoviesResponse.self, from: JSONDATA!)
            completion(responseModel)
    }
    
    func getFavoritesList(completion: @escaping ((FavoriteResponse?) -> Void)) {
        guard let url = Bundle(for: type(of: self)).path(forResource: "MovieJson", ofType: "json") else {
            fatalError("Didn't find it")
        }
        guard let json = try? String(contentsOfFile: url,encoding: .utf8) else {
            fatalError("Didn't find it")
        }
            let JSONDATA = json.data(using: .utf8)
            let jsonDecoder = JSONDecoder()
            let responseModel = try? jsonDecoder.decode(FavoriteResponse.self, from: JSONDATA!)
            completion(responseModel)
        }
    
}

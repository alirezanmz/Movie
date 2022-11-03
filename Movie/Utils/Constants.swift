//
//  Constants.swift
//  Movie
//
//  Created by Alireza Namazi on 4/24/22.
//

import UIKit
struct Constants {
    static let baseURL = "https://61efc467732d93001778e5ac.mockapi.io"
    static let retrievingImageURL = "https://image.tmdb.org/t/p/original/"
    struct APIService {
        static let MoviesList = Constants.baseURL + "/movies/list"
        static let FavoriteMoviesList = Constants.baseURL + "/movies/favorites"
        
    }
    struct CustomFont {
        static let Avenir_Regular_20: UIFont = UIFont(name: "Avenir-Book", size: 20)!
        static let Avenir_Regular_13: UIFont = UIFont(name: "Avenir-Book", size: 13)!
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

//
//  APIService.swift
//  Movie
//
//  Created by Alireza Namazi on 4/25/22.
//

import Foundation
import Alamofire
import ANActivityIndicator
import GSMessages
open class APIService {
    
    private func handleResponse<T: Decodable>(_ response: AFDataResponse<Data?>, completion: @escaping (T?, APIResponseStatus) -> Void) {
           guard let statusCode = response.response?.statusCode else {
               completion(nil, .failure)
               return
           }
           
        guard statusCode == 200 || statusCode == 201 else {
               completion(nil, .failure)
               return
           }
           
           if let data = response.data {
               let jsonDecoder = JSONDecoder()
               do {
                   let result = try jsonDecoder.decode(T.self, from: data)
                   completion(result, .success)
               } catch {
                   print("Error decoding response data:", error)
                   completion(nil, .failure)
               }
           } else {
               completion(nil, .failure)
           }
       }
       
    
    func getMoviesList(completion: @escaping ((MoviesResponse?, APIResponseStatus) -> Void)) {
        guard let url = URL(string: Constants.APIService.MoviesList) else { return }
            ANActivityIndicatorPresenter.shared.showIndicator()
        AF.request(url, method: .get, parameters: nil).response { response in
            self.handleResponse(response, completion: completion)
            ANActivityIndicatorPresenter.shared.hideIndicator()
        }
    }
    
    func getFavoritesList(completion: @escaping ((FavoriteResponse?, APIResponseStatus) -> Void)) {
        guard let url = URL(string: Constants.APIService.FavoriteMoviesList) else { return }
            ANActivityIndicatorPresenter.shared.showIndicator()
        AF.request(url, method: .get, parameters: nil).response { response in
            self.handleResponse(response, completion: completion)
            ANActivityIndicatorPresenter.shared.hideIndicator()
        }
    }
}

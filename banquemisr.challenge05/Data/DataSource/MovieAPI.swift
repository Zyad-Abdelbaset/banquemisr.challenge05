//
//  MovieAPI.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 27/09/2024.
//

import Foundation
class MovieAPI {
    static var shared = MovieAPI()
    private let baseUrl = "https://api.themoviedb.org/3/movie/"
    private let apiKey = "95a89943de5af0ccb83f6a10a3c30c21"
    private let imageUrlHeader = "https://image.tmdb.org/t/p/"
    private let posterSize = "w400"
    private init(){}
    func fetchMovies(endPoint:MovieListEndPoints,completion: @escaping (Result<[Movie], MovieError>) -> Void) {
        // API logic to fetch movies data
        // URL
        guard let url = URL(string: "\(baseUrl)\(endPoint.rawValue)?api_key=\(apiKey)") else { completion(.failure(.apiError)); return  }
        // Request and force cache it
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
        //DataTask
        URLSession.shared.dataTask(with: request) { data, response, error in
            //check Error
            if let error = error{
                completion(.failure(.apiError))
                return
            }
            //check data response
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            DataParser.parsingData(data: data, model: MoviesResponse.self) { movieResponse, error in
                if let error = error{
                    completion(.failure(error))
                    return
                }
                completion(.success(movieResponse!.movies))
            }
        }.resume()
    }
}

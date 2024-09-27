//
//  MoviesReposatories.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 27/09/2024.
//

import Foundation
protocol MovieRepository {
    func getMovies(endPoint:MovieListEndPoints,completion: @escaping (Result<[Movie], Error>) -> Void)
}

class MovieRepositoryImpl: MovieRepository {
    private let api: MovieAPI
    
    init(api: MovieAPI) {
        self.api = api
    }
    
    func getMovies(endPoint:MovieListEndPoints,completion: @escaping (Result<[Movie], Error>) -> Void) {
        api.fetchMovies(endPoint:endPoint ) { result in
            switch result {
            case .success(let movies):
                // Convert DTOs (from the API) to Domain Models
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

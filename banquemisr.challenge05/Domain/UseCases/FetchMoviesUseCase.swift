//
//  FetchMoviesUseCase.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 27/09/2024.
//

import Foundation
protocol FetchMoviesUseCase {
    func execute(endPoint:MovieListEndPoints,completion: @escaping (Result<[MoviesList],MovieError>,Bool) -> Void)
}
class FetchMoviesUseCaseImpl: FetchMoviesUseCase {
    private let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func execute(endPoint:MovieListEndPoints,completion: @escaping (Result<[MoviesList], MovieError>,Bool) -> Void) {
        repository.getMovies(endPoint: endPoint) { result,connectionFlag in
            // Additional domain logic can be added here if needed
            completion(result,connectionFlag)
        }
    }
}

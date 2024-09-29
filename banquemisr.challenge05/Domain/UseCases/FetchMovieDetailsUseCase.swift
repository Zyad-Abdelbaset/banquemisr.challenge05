//
//  FetchMovieDetailsUseCase.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 28/09/2024.
//

import Foundation
protocol FetchMovieDetailsUseCase {
    func execute(MovieId:String,completion: @escaping (Result<MovieDetailsEntity,MovieError>,Bool) -> Void)
}
class FetchMovieDetailsUseCaseImpl: FetchMovieDetailsUseCase {
    private let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    func execute(MovieId:String,completion: @escaping (Result<MovieDetailsEntity, MovieError>,Bool) -> Void) {
        repository.getMovieDetails(movieId: MovieId){ result,connectionFlag in
            // Additional domain logic can be added here if needed
            completion(result,connectionFlag)
            
        }
    }}

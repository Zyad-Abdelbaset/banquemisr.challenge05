//
//  MovieCellViewModel.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 27/09/2024.
//

import Foundation
class MovieCellViewModel{
    var model:MoviesList
    private let movieRepo:MovieRepository
    init(model:MoviesList){
        self.model=model
        movieRepo = MovieRepositoryImpl()
    }
    
    func getMovieImage(completion:@escaping (Result<Data,MovieError>)->Void){
        movieRepo.getMovieImage(imgPath: self.model.posterPath) { result in
            switch result {
            case .success(let data): completion(.success(data))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}

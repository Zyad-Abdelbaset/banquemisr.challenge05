//
//  MoviesReposatories.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 27/09/2024.
//

import Foundation
protocol MovieRepository {
    func getMovies(endPoint:MovieListEndPoints,completion: @escaping (Result<[MoviesList], MovieError>,Bool) -> Void)
    func getMovieDetails(movieId:String,completion: @escaping (Result<MovieDetailsEntity, MovieError>,Bool) -> Void)
    func getMovieImage(imgPath:String,completion: @escaping (Result<Data, MovieError>) -> Void)
}

class MovieRepositoryImpl: MovieRepository {
    func getMovieDetails(movieId: String, completion: @escaping (Result<MovieDetailsEntity, MovieError>, Bool) -> Void) {
        networkChecker.checkConnectivity { connectionFlag in
            if connectionFlag {
                self.api.fetchMovies(endPoint:movieId, model: MovieDetailsEntity.self ) { result in
                    switch result {
                    case .success(let movies):
                        completion(.success(movies),true)
                        self.coreDataManager.addingMovieDetailsToDB(movieDetail: movies)
                    case .failure(let error):
                        print()
                        completion(.failure(error),true)
                    }
                }
            }else{
                let arr = self.coreDataManager.getSpecificMovieDetails(MovieId: movieId)
                if arr.count > 0 {
                    completion(.success(arr.first!),false)
                }else{
                    completion(.failure(.noData),false)
                }
            }
        }
    }
    
    private let api: MovieAPI
    private let coreDataManager: CoreDataManager
    private let networkChecker: ConnectionProtocol
    init() {
        self.api = MovieAPI.shared
        coreDataManager = CoreDataManager.shared
        networkChecker = Connection.shared
    }
    
    func getMovies(endPoint:MovieListEndPoints,completion: @escaping (Result<[MoviesList], MovieError>,Bool) -> Void) {
        networkChecker.checkConnectivity { connectionFlag in
            if connectionFlag {
                self.api.fetchMovies(endPoint:endPoint.rawValue, model: MoviesResponse.self ) { result in
                    switch result {
                    case .success(let movies):
                        completion(.success(movies.movies),true)
                        //let serialqueue = DispatchQueue(label: "handling coredata")
                        DispatchQueue.main.async {
                                //self.coreDataManager.deleteAllMovies(endPoint: endPoint)
                            self.coreDataManager.addingMoviesToDB(arrMovies: movies.movies, endPoint: endPoint)
                        }
                    case .failure(let error):
                        completion(.failure(error),true)
                    }
                }
            }else{
                completion(.success(self.coreDataManager.getMovies(endPoint: endPoint)),false)
            }
        }
        
    }
    
    func getMovieImage(imgPath:String,completion: @escaping (Result<Data, MovieError>) -> Void){
        networkChecker.checkConnectivity { connectionFlag in
            if connectionFlag{
                self.api.fetchMovieImage(imgPath: imgPath) { result in
                    switch result{
                    case .success(let imgData): completion(.success(imgData))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }else{
                if let data = Data(base64Encoded: imgPath,options: .ignoreUnknownCharacters){
                    completion(.success(data))
                }else{
                    completion(.failure(.invalidResponse))
                }
            }
        }
        
    }
}

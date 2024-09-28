//
//  MoviesReposatories.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 27/09/2024.
//

import Foundation
protocol MovieRepository {
    func getMovies(endPoint:MovieListEndPoints,completion: @escaping (Result<[MoviesList], MovieError>,Bool) -> Void)
    func getMovieImage(imgPath:String,completion: @escaping (Result<Data, MovieError>) -> Void)
}

class MovieRepositoryImpl: MovieRepository {
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
                self.api.fetchMovies(endPoint:endPoint ) { result in
                    switch result {
                    case .success(let movies):
                        completion(.success(movies),true)
                        //let serialqueue = DispatchQueue(label: "handling coredata")
                        DispatchQueue.main.async {
                                //self.coreDataManager.deleteAllMovies(endPoint: endPoint)
                                self.coreDataManager.addingMoviesToDB(arrMovies: movies, endPoint: endPoint)
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

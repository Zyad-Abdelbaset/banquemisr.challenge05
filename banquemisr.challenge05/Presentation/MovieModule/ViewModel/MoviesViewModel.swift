//
//  NowPlayingViewModel.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 27/09/2024.
//

import Foundation
class MoviesViewModel{
    private let fetchMoviesUseCase: FetchMoviesUseCase
    var arrMovies:[Movie]=[]
    private let connection: ConnectionProtocol
    var reloadTV : (()->Void) = {}
    var noResult : ((String)->Void) = {_ in }
    var navigateForward : (()->Void) = {}
    var endPint:MovieListEndPoints
    init(endPoint:MovieListEndPoints){
        fetchMoviesUseCase = FetchMoviesUseCaseImpl(repository: MovieRepositoryImpl(api: MovieAPI.shared))
        self.connection = Connection.shared
        self.endPint = endPoint
    }
    func checkNetworkConnection(completion: @escaping (Bool) -> Void) {
            connection.checkConnectivity { isConnected in
                completion(isConnected)
            }
        }
    func fetchMovies() {
        fetchMoviesUseCase.execute(endPoint: endPint) { [weak self] result in
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async {
                        self?.arrMovies = movies
                        self?.reloadTV()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.noResult(error.localizedDescription)
                    }
                }
            }
        }
}

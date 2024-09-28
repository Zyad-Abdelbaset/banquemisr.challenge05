//
//  NowPlayingViewModel.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 27/09/2024.
//

import Foundation
class MoviesViewModel{
    private let fetchMoviesUseCase: FetchMoviesUseCase
    var arrMovies:[MoviesList]=[]
    var onlineFlag:String = "Checking"
    private let connection: ConnectionProtocol
    var reloadTV : (()->Void) = {}
    var noResult : ((String)->Void) = {_ in }
    var navigateForward : (()->Void) = {}
    var endPint:MovieListEndPoints
    init(endPoint:MovieListEndPoints){
        fetchMoviesUseCase = FetchMoviesUseCaseImpl(repository: MovieRepositoryImpl())
        self.connection = Connection.shared
        self.endPint = endPoint
    }
    func checkNetworkConnection(completion: @escaping (Bool) -> Void) {
            connection.checkConnectivity { isConnected in
                completion(isConnected)
            }
        }
    func fetchMovies() {
        fetchMoviesUseCase.execute(endPoint: endPint) { [weak self] result,flag in
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async {
                        self?.arrMovies = movies
                        self?.onlineFlag = flag ? "Online" : "Offline"
                        self?.reloadTV()
                        if !flag {
                            self?.noResult(MovieError.noConnection.localizedDescription)
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.noResult(error.localizedDescription)
                    }
                }
            }
        }
}

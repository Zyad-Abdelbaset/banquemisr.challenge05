//
//  MovieDetailsViewModel.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 28/09/2024.
//

import Foundation
class MovieDetailsViewModel{
    var model:MovieDetailsEntity?
    private let fetchMovieDetailsUseCase:FetchMovieDetailsUseCase
    var onlineFlag:String = "Checking"
    var noResult : ((String)->Void) = {_ in }
    var putData : (()->Void) = {}
    var movieRepo:MovieRepository
    var movieId:String
    
    init(movieId:String){
        self.movieId = movieId
        movieRepo = MovieRepositoryImpl()
        fetchMovieDetailsUseCase = FetchMovieDetailsUseCaseImpl(repository: MovieRepositoryImpl())
        fetchMovieDetails()
    }
    func getMovieImage(completion:@escaping (Result<Data,MovieError>)->Void){
        self.model = MovieDetailsEntity(adult: true, backdropPath: "/7h6TqPB3ESmjuVbxCxAeB1c9OB1.jpg", budget: 2000, genres: [], id: 1234, originalLanguage: "en", overview: "Good movie", releaseDate: "2024", runtime: 140, status: "released", title: "The Substance")
        movieRepo.getMovieImage(imgPath: self.model!.backdropPath) { result in
            switch result {
            case .success(let data): completion(.success(data))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    func fetchMovieDetails(){
        fetchMovieDetailsUseCase.execute(MovieId: movieId) {[weak self] result, flag in
            switch result{
            case .success(let movie):DispatchQueue.main.async{
                self?.model = movie
                self?.putData()
                print("Succed in fetching data")
            }
            case .failure(let error):
                DispatchQueue.main.async{
                    self?.noResult(error.localizedDescription)
                    print(error.localizedDescription)
                    print("Error in fetching data")
                }
            }
            
        }
    }
    
}

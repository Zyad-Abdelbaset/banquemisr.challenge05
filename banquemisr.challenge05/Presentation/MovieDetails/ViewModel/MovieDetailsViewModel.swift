//
//  MovieDetailsViewModel.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 28/09/2024.
//

import Foundation
class MovieDetailsViewModel{
    var model:MovieDetailsEntity!
    private let fetchMovieDetailsUseCase:FetchMovieDetailsUseCase
    var onlineFlag:String = "Checking"
    var noResult : ((String)->Void) = {_ in }
    var putData : (()->Void) = {}
    var movieId:String
    
    init(movieId:String){
        self.movieId = movieId
        fetchMovieDetailsUseCase = FetchMovieDetailsUseCaseImpl(repository: MovieRepositoryImpl())
        fetchMovieDetails()
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

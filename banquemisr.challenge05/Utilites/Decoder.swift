//
//  Decoder.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 27/09/2024.
//

import Foundation

class DataParser{
    //Using to SerlaizeData to specific Model
    static func parsingData<T: Decodable>(data:Data,model:T.Type,completion:(T?,MovieError?)->Void){
        do{
            let decodedData = try JSONDecoder().decode(model, from: data)
            completion(decodedData, nil)
        }catch _{
            completion(nil, .serializationError)
        }
    }
    //Take string and return image in Data Format
    static func parsingimgPathToString(imgPath:String,compeletion:@escaping(Result<String,MovieError>)->Void){
        MovieRepositoryImpl().getMovieImage(imgPath: imgPath) { result in
            switch result {
            case .success(let data): compeletion(.success(data.base64EncodedString(options: .lineLength64Characters)))
            case .failure(let error): compeletion(.failure(error))
            }
        }
    }
    //Convert Moviearr in CoreData to Movie arr Model
    static func converter(arr:[MovieModel])->[MoviesList]{
        var arrMovie: [MoviesList]=[]
        for item in arr{
            let obj = MoviesList(id: Int(item.id), posterPath: item.poster ?? "", releaseDate: item.releaseDate ?? "No date", title: item.title ?? "No title")
            
            arrMovie.append(obj)
        }
        return arrMovie
    }
    static func converterMovie(movieModel:[MovieDetailsModel])->[MovieDetailsEntity]{
        var arrMovie: [MovieDetailsEntity]=[]
        for item in movieModel{
            let obj = MovieDetailsEntity(adult:item.adult, backdropPath: item.image ?? "", budget: Int(item.budget), genres: [Genre(name: item.geners ?? "")], id: Int(item.id), originalLanguage: item.originalLanguage ?? "", overview: item.overview ?? "", releaseDate: item.releaseDate ?? "", runtime: Int(item.runtime), status: item.status ?? "", title: item.title ?? "No title")
            
            arrMovie.append(obj)
        }
        return arrMovie
    }
    
}

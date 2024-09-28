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
        }catch let error{
            //print("Request failed with error: \(error)")
            if
               let errorResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
              //  print("Error response body: \(errorResponse)")
            }
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
    
}

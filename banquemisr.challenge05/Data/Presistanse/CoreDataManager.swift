//
//  CoreDataManager.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 27/09/2024.
//

import Foundation
import CoreData


class CoreDataManager{
    static let shared = CoreDataManager()
    private init(){}
    func addingMoviesToDB(arrMovies: [MoviesList], endPoint: MovieListEndPoints) {
        // Delete all movies synchronously before starting the additions
        deleteAllMovies(endPoint: endPoint)

        let optQueue = OperationQueue()
        optQueue.maxConcurrentOperationCount = 1 // Serial execution
        
        var arr = [MovieModel]()
        let group = DispatchGroup() // Correct usage of DispatchGroup
        
        for item in arrMovies {
            group.enter() // Ensure to enter the group here
            
            let obj = MovieModel(context: context)
            obj.id = Int64(item.id)
            obj.releaseDate = item.releaseDate
            obj.title = item.title
            obj.type = endPoint.rawValue
            let block2 = BlockOperation {
                let posterPath = item.posterPath
                // Create a dispatch group to wait for image parsing completion
                let imgGroup = DispatchGroup()
                imgGroup.enter()
                DataParser.parsingimgPathToString(imgPath: posterPath) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let str):
                            obj.poster = str
                        case .failure:
                            obj.poster = ""
                        }
                        imgGroup.leave()
                    }
                }
                
                // Wait for the image parsing tasks to complete
                imgGroup.notify(queue: .main) {
                    // Safely append to the array on the main thread
                    arr.append(obj)
                    group.leave() // Leave the group after appending the object
                }
            }
            // Add the operation to the queue
            optQueue.addOperations([block2], waitUntilFinished: false)
        }
        // Notify when all operations and the dispatch group are done
        group.notify(queue: .main) {
            self.saveContext() // Save context on the main thread
        }
    }

    func deleteAllMovies(endPoint:MovieListEndPoints) {
        let fetchRequest: NSFetchRequest<MovieModel> = MovieModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "type CONTAINS %@", endPoint.rawValue)
        do {
            let result = try context.fetch(fetchRequest)
            for item in result {
                context.delete(item)
            }
            self.saveContext()
        } catch {
            print("Error in deleting Data")
        }
    }
    func getMovies(endPoint:MovieListEndPoints) -> [MoviesList] {
        let fetchRequest: NSFetchRequest<MovieModel> = MovieModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "type CONTAINS %@", endPoint.rawValue)
        var arr: [MovieModel] = []
        do {
            arr = try context.fetch(fetchRequest)
        } catch {
            print("Error in fetching Data")
        }
        return DataParser.converter(arr: arr)
    }
    private func saveContext() {
        DispatchQueue.main.async {
            do {
                try context.save()
            } catch {
                print("Cannot save in save context")
            }
        }
    }
    
    
}


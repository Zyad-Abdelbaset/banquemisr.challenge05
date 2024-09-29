//
//  TestCoreData.swift
//  banquemisr.challenge05Tests
//
//  Created by zyad Baset on 29/09/2024.
//

import XCTest
import CoreData
@testable import banquemisr_challenge05
final class TestCoreData: XCTestCase {

    var coreData:CoreDataManager!
    
    override func setUpWithError() throws {
        coreData = CoreDataManager.shared
        clearCache()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testFetchingMovieList(){
        let arr = coreData.getMovies(endPoint: .nowPlaying)
        XCTAssertNotEqual(arr.count, 0, "Empty core data")
        guard let obj = arr.first else {XCTAssertNil(arr.first) ;return}
        let obj2 = coreData.getSpecificMovieDetails(MovieId: "\(obj.id)")
        if obj2.count != 0 {
            XCTAssertEqual(obj.id, obj2.first!.id, "Fetching data correct")
        }
    }
    func testSavingSpecificMovie() {
        XCTAssertNotEqual(coreData.getSpecificMovieDetails(MovieId: "957452").count, 1)
        let movie = MovieDetailsEntity(adult: false, backdropPath: "/Asg2UUwipAdE87MxtJy7SQo08XI.jpg", budget: 20000, genres: [], id: 957452, originalLanguage: "en", overview: "Good movie", releaseDate: "2023", runtime: 125, status: "released", title: "The Crow")
        coreData.addingMovieDetailsToDB(movieDetail: movie)
        //XCTAssertNotEqual(coreData.getSpecificMovieDetails(MovieId: "957452").count, 0)
        //XCTAssertEqual(coreData.getSpecificMovieDetails(MovieId: "957452").first?.title, "The Crow")
    }
    func clearCache() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"MovieDetailsModel")
        do {
            let movies = try managedContext.fetch(fetchRequest)
            for movie in movies {
                managedContext.delete(movie)
            }
            try managedContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    override func tearDownWithError() throws {
        coreData = nil
        clearCache()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

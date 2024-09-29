//
//  TestMovieDetailsViewModel.swift
//  banquemisr.challenge05Tests
//
//  Created by zyad Baset on 29/09/2024.
//

import XCTest
@testable import banquemisr_challenge05
final class TestMovieDetailsViewModel: XCTestCase {
    var viewModel:MovieDetailsViewModel!
    override func setUpWithError() throws {
        viewModel = MovieDetailsViewModel(movieId: "957452")
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testFetchSpecificMovie(){
        let opt = OperationQueue()
        let exp = expectation(description: "Waiting view model finish hitting network")
        let block1 = BlockOperation {
            self.viewModel.fetchMovieDetails()
            exp.fulfill()
        }
        var block2 = BlockOperation()
        block2.addDependency(block1)
        opt.addOperations([block1,block2], waitUntilFinished: false)
        XCTAssertEqual(viewModel.onlineFlag, "Checking")
        waitForExpectations(timeout: 3)
        block2 = BlockOperation {
           XCTAssertEqual(self.viewModel.model!.title, "The Crow")
       }
    }
    
    func testFetchImage(){
        let exp = expectation(description: "Waiting Fetching image")
        viewModel.model = MovieDetailsEntity(adult: false, backdropPath: "/Asg2UUwipAdE87MxtJy7SQo08XI.jpg", budget: 20000, genres: [], id: 957452, originalLanguage: "en", overview: "Good movie to watch", releaseDate: "2024", runtime: 115, status: "released", title: "The Crow")
        viewModel.getMovieImage { result in
            switch result {
            case .success(let imgData): XCTAssertNotNil(imgData);exp.fulfill()
            case .failure(let error): XCTFail(error.localizedDescription);exp.fulfill()
            }
        }
        waitForExpectations(timeout: 3)
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }


  
}

//
//  TestMockingMoviesList.swift
//  banquemisr.challenge05Tests
//
//  Created by zyad Baset on 29/09/2024.
//

import XCTest
@testable import banquemisr_challenge05

final class TestMockingMoviesList: XCTestCase {

    var viewModel: MoviesViewModel!
    override func setUpWithError() throws {
        viewModel = MoviesViewModel(endPoint: .nowPlaying)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }


    func testFetchMovies(){
        let opt = OperationQueue()
        let exp = expectation(description: "Waiting view model finish hitting network")
        let block1 = BlockOperation {
            self.viewModel.fetchMovies()
        }
        var block2 = BlockOperation()
        block2.addDependency(block1)
        block2 = BlockOperation {
            exp.fulfill()
            XCTAssertNotEqual(self.viewModel.arrMovies.count, 0)
        }
        XCTAssertEqual(viewModel.onlineFlag, "Checking")
        waitForExpectations(timeout: 3)
    }
        
    

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}


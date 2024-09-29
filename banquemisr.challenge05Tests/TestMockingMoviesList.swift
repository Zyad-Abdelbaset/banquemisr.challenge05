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
            exp.fulfill()
        }
        var block2 = BlockOperation()
        block2.addDependency(block1)
        opt.addOperations([block1,block2], waitUntilFinished: false)
        XCTAssertEqual(viewModel.onlineFlag, "Checking")
        waitForExpectations(timeout: 3)
        block2 = BlockOperation {
            XCTAssertNotEqual(self.viewModel.arrMovies.count, 0)
        }
    }
        


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}


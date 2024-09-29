//
//  TestFetchMoviesUseCase.swift
//  banquemisr.challenge05Tests
//
//  Created by zyad Baset on 29/09/2024.
//

import XCTest
@testable import banquemisr_challenge05
final class TestFetchMoviesUseCase: XCTestCase {

    var fetchMovieUseCase:FetchMoviesUseCase!
    override func setUpWithError() throws {
        fetchMovieUseCase = FetchMoviesUseCaseImpl(repository: MovieRepositoryImpl())
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testExcute(){
        let exp = expectation(description: "Waiting for fetchingData")
        fetchMovieUseCase.execute(endPoint: .nowPlaying) { result, flag in
            switch result{
            case .success(let arr): XCTAssertNotEqual(arr.count, 0);exp.fulfill()
            case .failure(let error): XCTAssertNotNil(error)
            }
        }
        waitForExpectations(timeout: 3)
    }
    override func tearDownWithError() throws {
        fetchMovieUseCase = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

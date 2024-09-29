//
//  TestingNetwork.swift
//  banquemisr.challenge05Tests
//
//  Created by zyad Baset on 29/09/2024.
//

import XCTest
@testable import banquemisr_challenge05
final class TestingNetwork: XCTestCase {

    var movieAPI:MovieAPI?
    override func setUpWithError() throws {
        movieAPI = MovieAPI.shared
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        movieAPI = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testFetchSpecificMovie(){
        let myExpectation = expectation(description: "wait api")
        movieAPI!.fetchMovies(endPoint: "933260", model: MovieDetailsEntity.self) { result in
            switch result{
            case .success(let data): XCTAssertNotNil(data, "Nil inside data");myExpectation.fulfill();XCTAssertEqual(data.title, "The Substance")
            case .failure(let error): XCTFail("Faild to fetch data\(error.localizedDescription)")
            }
        }
        waitForExpectations(timeout: 2)
        
    }
    func testFetchingImage(){
        let myExpectation = expectation(description: "wait api")
        movieAPI!.fetchMovieImage(imgPath: "/Asg2UUwipAdE87MxtJy7SQo08XI.jpg") { result in
            switch result{
            case .success(let data ): XCTAssertNotNil(data, "Nil inside data");myExpectation.fulfill()
            case .failure(let error): XCTFail("Faild to fetch data\(error.localizedDescription)")
            }
        }
        waitForExpectations(timeout: 2)
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

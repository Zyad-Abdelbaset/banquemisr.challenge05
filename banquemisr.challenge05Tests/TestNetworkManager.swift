//
//  TestNetworkManager.swift
//  banquemisr.challenge05Tests
//
//  Created by zyad Baset on 29/09/2024.
//

import XCTest
@testable import banquemisr_challenge05
final class TestNetworkManager: XCTestCase {

    var connection : ConnectionProtocol!
    override func setUpWithError() throws {
        connection = Connection.shared
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testConnectivity(){
        let exp = expectation(description: "Waiting checking Network")
        connection.checkConnectivity { flag in
            if flag {
                exp.fulfill();
            }else{
                XCTFail("Faild test")
                exp.fulfill();
            }
        }
        waitForExpectations(timeout: 3)
    }
    override func tearDownWithError() throws {
        connection = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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

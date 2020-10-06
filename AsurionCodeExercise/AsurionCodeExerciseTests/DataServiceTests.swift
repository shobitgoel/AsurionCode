//
//  DataServiceTests.swift
//  AsurionCodeExerciseTests
//
//  Created by Goel, Shobit on 06/10/20.
//  Copyright © 2020 Goel, Shobit. All rights reserved.
//

import XCTest
@testable import AsurionCodeExercise

class DataServiceTests: XCTestCase {
    
    let mockDataService = MockDataService()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testLoadConfigAPIHappyPath() {
        
        let expectation = self.expectation(description: "Load config service test - happy path")
        
        mockDataService.loadConfig { (config, error) in
            XCTAssertNil(error)
            
            guard let config = config else {
                XCTFail()
                return
            }
            
            XCTAssertNotNil(config)
            XCTAssertTrue(config.isChatEnabled)
            XCTAssertTrue(config.isCallEnabled)
            XCTAssertNotNil(config.workHours)
            
            expectation.fulfill()
            self.waitForExpectations(timeout: 10, handler: nil)
        }
    }
    
    func testLoadConfigAPIFailurePath() {
        
        mockDataService.shouldReturnError = true
        
        let expectation = self.expectation(description: "Load config service test - fail path")
        mockDataService.loadConfig { (config, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(config)
            expectation.fulfill()
            self.waitForExpectations(timeout: 10, handler: nil)
        }
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

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
    
    func testLoadConfigAPIPositiveScenario() {
        
        let expectation = self.expectation(description: "testLoadConfigAPIPositiveScenario - Test should pass if no error is mocked")
        
        mockDataService.loadConfig { (json, error) in
            
            XCTAssertNil(error)
            guard let json = json else {
                XCTFail()
                return
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                guard let settings = DataDecoder<Settings>.decode(data: jsonData) else {
                    XCTFail()
                    return
                }
                XCTAssertNotNil(settings)
                expectation.fulfill()
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testLoadConfigAPINegativeScenario1() {
        
        mockDataService.invalidJSON = true
        
        let expectation = self.expectation(description: "testLoadConfigAPINegativeScenario1 - Test should handle if invalid json is mocked")
        
        mockDataService.loadConfig { (json, error) in
            
            XCTAssertNil(error)
            guard let json = json else {
                XCTFail()
                return
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                let settings = DataDecoder<Settings>.decode(data: jsonData)
                XCTAssertNil(settings)
                expectation.fulfill()
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testLoadConfigAPINegativeScenario2() {
        
        mockDataService.shouldReturnError = true
        
        let expectation = self.expectation(description: "testLoadConfigAPINegativeScenario2 - Test should handle if error is mocked")
        
        mockDataService.loadConfig { (json, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(json)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
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

//
//  ConfigTests.swift
//  AsurionCodeExerciseTests
//
//  Created by Goel, Shobit on 08/10/20.
//  Copyright © 2020 Goel, Shobit. All rights reserved.
//

import XCTest
@testable import AsurionCodeExercise

class ConfigTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testGetDecodedWorkHoursPositiveScenario() {
        
        let expectation = self.expectation(description: "testGetDecodedWorkHoursPositiveScenario: Test should pass provided valid work hours string")
        
        let config = Config(isChatEnabled: true, isCallEnabled: true, workHours: "M-F 9:00 - 18:00")
        let decodedWorkHours =  config.getDecodedWorkHours()
        XCTAssertNotNil(decodedWorkHours)
        XCTAssertEqual(2, decodedWorkHours?.0.rawValue)
        XCTAssertEqual(6, decodedWorkHours?.1.rawValue)
        XCTAssertEqual(9, decodedWorkHours?.2)
        XCTAssertEqual(0, decodedWorkHours?.3)
        XCTAssertEqual(18, decodedWorkHours?.4)
        XCTAssertEqual(0, decodedWorkHours?.5)
        expectation.fulfill()
        
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetDecodedWorkHoursNegativeScenario1() {
        
        let expectation = self.expectation(description: "testGetDecodedWorkHoursNegativeScenario1: Test should pass provided invalid work hours string")
        
        let config = Config(isChatEnabled: true, isCallEnabled: true, workHours: "M-F9:00 - 18:00")
        let decodedWorkHours =  config.getDecodedWorkHours()
        XCTAssertNil(decodedWorkHours)
        expectation.fulfill()
        
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetDecodedWorkHoursNegativeScenario2() {
        
        let expectation = self.expectation(description: "testGetDecodedWorkHoursNegativeScenario2: Test should pass provided empty work hours string")
        
        let config = Config(isChatEnabled: true, isCallEnabled: true, workHours: "")
        let decodedWorkHours =  config.getDecodedWorkHours()
        XCTAssertNil(decodedWorkHours)
        expectation.fulfill()
        
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetDecodedWorkHoursNegativeScenario3() {
        
        let expectation = self.expectation(description: "testGetDecodedWorkHoursNegativeScenario3: Test should pass provided random work hours string")
        
        let config = Config(isChatEnabled: true, isCallEnabled: true, workHours: "aaabbbccc")
        let decodedWorkHours =  config.getDecodedWorkHours()
        XCTAssertNil(decodedWorkHours)
        expectation.fulfill()
        
        self.waitForExpectations(timeout: 5, handler: nil)
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

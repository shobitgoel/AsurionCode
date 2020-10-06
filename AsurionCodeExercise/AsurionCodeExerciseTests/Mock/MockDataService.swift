//
//  MockDataService.swift
//  AsurionCodeExerciseTests
//
//  Created by Goel, Shobit on 06/10/20.
//  Copyright © 2020 Goel, Shobit. All rights reserved.
//

import Foundation
@testable import AsurionCodeExercise

class MockDataService {
    
    var shouldReturnError = false
    
    enum MockAPIError: Error {
        case config
    }
}

extension MockDataService: DataServiceProtocol {
    
    func loadConfig(_ completionHandler: @escaping (Config?, Error?) -> Void) {
        
        if shouldReturnError {
            completionHandler(nil, MockAPIError.config)
        } else {
            completionHandler(Config(isChatEnabled: true, isCallEnabled: true, workHours: "M-F 9-18"), nil)
        }
    }
}

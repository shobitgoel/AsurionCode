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
    var invalidJSON = false
    
    enum MockAPIError: Error {
        case config
    }
    
    convenience init() {
        self.init(false, false)
    }
    
    init(_ shouldReturnError: Bool, _ invalidJSON: Bool) {
        self.shouldReturnError = shouldReturnError
        self.invalidJSON = invalidJSON
    }
    
    let mockConfigResponse: [String: Any] = [
        "settings": [
            "isCallEnabled": true,
            "isChatEnabled": true,
            "workHours": "M-F 9:00 - 18:00"
        ]
    ]
    
    let mockInvalidConfigResponse: [String: Any] = [
        "settings": [
            "isCallEnabled-invalid": true,
            "isChatEnabled": true,
            "workHours": "M-F 9:00 - 18:00"
        ]
    ]
}

extension MockDataService {
    
    func loadConfig(_ completionHandler: @escaping ([String: Any]?, Error?) -> Void) {
        
        if shouldReturnError {
            completionHandler(nil, MockAPIError.config)
        } else if invalidJSON {
            completionHandler(mockInvalidConfigResponse, nil)
        } else {
            completionHandler(mockConfigResponse, nil)
        }
    }
}

//
//  Config.swift
//  AsurionCodeExercise
//
//  Created by Goel, Shobit on 06/10/20.
//  Copyright © 2020 Goel, Shobit. All rights reserved.
//

import Foundation

struct Config: Decodable {
    let isChatEnabled: Bool
    let isCallEnabled: Bool
    let workHours: String
}

struct Settings: Decodable {
    let config: Config
    
    enum CodingKeys: String, CodingKey {
        case config = "settings"
    }
}

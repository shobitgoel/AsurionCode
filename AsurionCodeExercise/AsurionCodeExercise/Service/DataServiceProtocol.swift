//
//  DataServiceProtocol.swift
//  AsurionCodeExercise
//
//  Created by Goel, Shobit on 06/10/20.
//  Copyright © 2020 Goel, Shobit. All rights reserved.
//

import Foundation

protocol DataServiceProtocol {
    
    func loadConfig(_ completionHandler: @escaping (Config?, Error?) -> Void)
}

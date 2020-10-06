//
//  DataDecoder.swift
//  AsurionCodeExercise
//
//  Created by Goel, Shobit on 04/10/20.
//  Copyright © 2020 Goel, Shobit. All rights reserved.
//

import Foundation

struct DataDecoder<T: Decodable> {
    
    static func decode(data: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            let model =  try decoder.decode(T.self, from: data)
            return model
        } catch {
            return nil
        }
    }
}

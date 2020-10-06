//
//  Pet.swift
//  AsurionCodeExercise
//
//  Created by Goel, Shobit on 06/10/20.
//  Copyright © 2020 Goel, Shobit. All rights reserved.
//

import Foundation

struct Pet {
    let imageURL: String
    let title: String
    let contentURL: String
    let date: String
}

extension Pet: Decodable {
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case title
        case contentURL = "content_url"
        case date = "date_added"
    }
}

struct Pets {
    let list: [Pet]
}

extension Pets: Decodable {
    enum CodingKeys: String, CodingKey {
        case list = "pets"
    }
}

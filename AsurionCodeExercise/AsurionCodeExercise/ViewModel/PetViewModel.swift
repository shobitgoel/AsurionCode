//
//  PetViewModel.swift
//  AsurionCodeExercise
//
//  Created by Goel, Shobit on 05/10/20.
//  Copyright © 2020 Goel, Shobit. All rights reserved.
//

import UIKit
import Foundation

class PetViewModel {
    
    var pets: Pets?
    
    func loadPets(_ completion: @escaping () -> ()) {
        DataService.shared.loadPets{ (pets, error) in
            guard let pets = pets, error == nil else {
                return
            }
            self.pets = pets
            completion()
        }
    }
    
    func loadImages(url: URL, completion: @escaping (UIImage?) -> Swift.Void) {
        ImageCache.publicCache.load(url: url as NSURL) { (image) in
            completion(image)
        }
    }
}

//
//  DataService.swift
//  AsurionCodeExercise
//
//  Created by Goel, Shobit on 04/10/20.
//  Copyright © 2020 Goel, Shobit. All rights reserved.
//

import Foundation

final class DataService {
    
    enum APIError: Error {
        case serviceError
    }
    
    static let shared = DataService()
    
    static let settingsURL = "https://api.jsonbin.io/b/5f76b84165b18913fc587397"
    static let petsURL = "https://api.jsonbin.io/b/5f76b9287243cd7e82489ccf"
    
    func loadPets(_ completionHandler: @escaping (Pets?, Error?) -> Void) {
        
        guard let url = URL(string: DataService.petsURL) else {
            completionHandler(nil, APIError.serviceError)
            return
        }
        
        execute(url: url) { (data, error) in
            guard let data = data, error == nil else {
                completionHandler(nil, APIError.serviceError)
                return
            }
            
            let pets = DataDecoder<Pets>.decode(data: data)
            if let pets = pets {
                completionHandler(pets, nil)
            } else {
                completionHandler(nil, APIError.serviceError)
            }
        }
    }
    
    private func execute(url: URL, _ completionHandler: @escaping (Data?, Error?) -> Void) {
        
        let urlSession = URLSession.shared
        
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            guard let responseStatus = response as? HTTPURLResponse, responseStatus.statusCode == 200 else {
                completionHandler(nil, APIError.serviceError)
                return
            }
            
            guard let data = data, error == nil else {
                completionHandler(nil, APIError.serviceError)
                return
            }
            
            completionHandler(data, nil)
        }
        dataTask.resume()
    }
}

extension DataService: DataServiceProtocol {
    
    func loadConfig(_ completionHandler: @escaping (Config?, Error?) -> Void) {
        
        guard let url = URL(string: DataService.settingsURL) else {
            completionHandler(nil, APIError.serviceError)
            return
        }
        
        execute(url: url) { (data, error) in
            
            guard let data = data, error == nil else {
                completionHandler(nil, APIError.serviceError)
                return
            }
            
            let settings = DataDecoder<Settings>.decode(data: data)
            if let settings = settings {
                completionHandler(settings.config, nil)
            } else {
                completionHandler(nil, APIError.serviceError)
            }
        }
    }
}

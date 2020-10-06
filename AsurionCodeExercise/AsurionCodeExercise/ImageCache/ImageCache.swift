//
//  ImageCache.swift
//  AsurionCodeExercise
//
//  Created by Goel, Shobit on 04/10/20.
//  Copyright © 2020 Goel, Shobit. All rights reserved.
//

import UIKit
import Foundation

class ImageCache {
    
    public static let publicCache = ImageCache()
    private let cachedImages = NSCache<NSURL, UIImage>()
    private var loadingResponses = [NSURL: [( UIImage?) -> Swift.Void]]()
    
    public final func image(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    
    final func load(url: NSURL, completion: @escaping (UIImage?) -> Swift.Void) {
        // Check for a cached image.
        if let cachedImage = image(url: url) {
            DispatchQueue.main.async {
                completion( cachedImage)
            }
            return
        }
        
        // In case there are more than one requestor for the image, we append their completion block.
        if loadingResponses[url] != nil {
            loadingResponses[url]?.append(completion)
            return
        } else {
            loadingResponses[url] = [completion]
        }
        
        // Go fetch the image.
        ImageCache.urlSession().dataTask(with: url as URL) { (data, response, error) in
            // Check for the error, then data and try to create the image.
            guard let responseData = data, let image = UIImage(data: responseData),
                let blocks = self.loadingResponses[url], error == nil else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
            }
            // Cache the image.
            self.cachedImages.setObject(image, forKey: url, cost: responseData.count)
            // Iterate over each requestor for the image and pass it back.
            for block in blocks {
                DispatchQueue.main.async {
                    block(image)
                }
                return
            }
        }.resume()
    }
    
    static func urlSession() -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        return  URLSession(configuration: config)
    }
}

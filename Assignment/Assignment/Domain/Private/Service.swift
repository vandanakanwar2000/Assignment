//
//  Service.swift
//  Assignment
//
//  Created by Vandana Kanwar on 16/5/20.
//  Copyright © 2020 Vandana Kanwar. All rights reserved.
//

import Foundation
import UIKit

/// Service Error Types.
enum ServiceError: Error {
    /// General error with message.
    case general(messsage: String)
    case noNetwork
}

/// Result type.
enum Result<T> {
    /// success.
    case success(T)

    /// failure.
    case failure(Error)
}

// MARK: - Types

/// Type for dictionary.
typealias JSON = [String: Any]

/// Service result.
typealias ServiceResult = Result<JSON>

/// Service callback.
typealias ServiceCallback = (ServiceResult) -> Void

/// Base service class
///
/// Implements common functionality for all service classess.
class Service {
    var cache: NSCache<NSString, UIImage>! = NSCache()
    typealias ImageCacheLoaderCompletionHandler = ((UIImage?) -> ())
    
    func fetch(with url: URL, completion: @escaping ServiceCallback) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else {
                if let data = data {
                    do {
                        if let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8),
                            let json = try JSONSerialization.jsonObject(with: utf8Data, options: []) as? JSON {
                            DispatchQueue.main.async {
                                completion(.success(json))
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            }
        }.resume()
    }
    
    func downloadImage(imagePath: String, completionHandler: @escaping ((UIImage?) -> ())) {
        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
            guard let url: URL = URL(string: imagePath) else {
                DispatchQueue.main.async {
                    completionHandler(nil)
                }
                return
            }
            
            URLSession.shared.downloadTask(with: url, completionHandler: { (location, response, error) in
                if let data = try? Data(contentsOf: url),
                    let img = UIImage(data: data) {
                    self.cache.setObject(img, forKey: imagePath as NSString)
                    DispatchQueue.main.async {
                        completionHandler(img)
                    }
                } else {  DispatchQueue.main.async {
                    completionHandler(nil)
                    }
                }
            }).resume()
        }
    }
}

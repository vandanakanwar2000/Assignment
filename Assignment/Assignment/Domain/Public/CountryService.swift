//
//  CountryService.swift
//  Assignment
//
//  Created by Vandana Kanwar on 16/5/20.
//  Copyright © 2020 Vandana Kanwar. All rights reserved.
//

import UIKit

/// CountryService protocol.
protocol CountryServiceProtocol {
    /// Retrieve weather info
    func fetch<T: Decodable>(url: URL,
                                 result: T.Type,
                                 completion: @escaping (Result<T>) -> Void)
}

class CountryService: Service, CountryServiceProtocol {
    func fetch<T>(url: URL, result: T.Type, completion: @escaping (Result<T>) -> Void) where T : Decodable {
        
        fetch(with: url) { result in
            switch result {
            case let .success(data):
                do {
                    let response = try JSONDecoder().decode(T.self, jsonObject: data)
                    completion(.success(response))
                } catch {
                    return completion(.failure(ServiceError.general(messsage: "Error")))
                }
                
            case let .failure(error):
                completion(.failure((ServiceError.general(messsage: error.localizedDescription))))
            }
        }
    }
}

//
//  MockService.swift
//  AssignmentTests
//
//  Created by Vandana Kanwar on 16/5/20.
//  Copyright © 2020 Vandana Kanwar. All rights reserved.
//

import XCTest
@testable import Assignment

class MockService: CountryService {
    private let mockPath: String?

    init(mockPath: String?) {
        self.mockPath = mockPath
    }
    
    override func fetch(with url: URL, completion: @escaping ServiceCallback) {
        guard let path = mockPath else {
            return completion(.failure(ServiceError.general(messsage: "Unable to find json")))
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            if let json = try JSONSerialization.jsonObject(with: data,
                                                           options: JSONSerialization.ReadingOptions()) as? JSON {
                completion(.success(json))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
}

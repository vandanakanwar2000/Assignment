//
//  AssignmentTests.swift
//  AssignmentTests
//
//  Created by Vandana Kanwar on 16/5/20.
//  Copyright © 2020 Vandana Kanwar. All rights reserved.
//

import XCTest
@testable import Assignment

class AssignmentTests: XCTestCase {
    
    let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
    
    func testCountryInfoHappyPath() {
        let service = MockService(mockPath: Stub.successFact.path)
        let expectations = expectation(description: #function)
        service.fetch(url: url, result: CountryModel.self) { result in
            switch result {
            case .success:
                expectations.fulfill()
            case .failure:
                break
            }
        }
        
        waitForExpectations(timeout: 0.3, handler: nil)
    }
    
    func testCountryInfoUnHappyPath() {
        let service = MockService(mockPath: Stub.failureFact.path)
        let expectations = expectation(description: #function)
        service.fetch(url: url, result: CountryModel.self) { result in
            switch result {
            case .success:
                break
            case .failure:
                expectations.fulfill()
            }
        }
        
        waitForExpectations(timeout: 0.3, handler: nil)
    }
    
    func testHappyPathForImageDownload() {
        let service = MockService(mockPath: Stub.successFact.path)
        let expectations = expectation(description: #function)
        service.loadImage(imagePath: "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg") { image in
            XCTAssertNotNil(image)
            expectations.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testUnHappyPathForImageDownload() {
        let service = MockService(mockPath: Stub.successFact.path)
        let expectations = expectation(description: #function)
        service.loadImage(imagePath: "") { image in
            XCTAssertNil(image)
            expectations.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}

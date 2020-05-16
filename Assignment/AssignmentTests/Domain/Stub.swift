//
//  Stub.swift
//  AssignmentTests
//
//  Created by Vandana Kanwar on 16/5/20.
//  Copyright © 2020 Vandana Kanwar. All rights reserved.
//

import XCTest

enum Stub: String {
    case successCountryInfo = "SuccessCountryInfo"
    case failureCountryInfo = "FailureCountryInfo"

    var path: String? {
        return Bundle(for: MockService.self).path(forResource: rawValue,
                                                  ofType: "json")
    }
}

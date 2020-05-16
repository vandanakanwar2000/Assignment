//
//  JSONDecoder + Decode.swift
//  Assignment
//
//  Created by Vandana Kanwar on 16/5/20.
//  Copyright © 2020 Vandana Kanwar. All rights reserved.
//
import Foundation

extension JSONDecoder {
    func decode<T>(_ type: T.Type, jsonObject: JSON) throws -> T where T: Decodable {
        keyDecodingStrategy = .convertFromSnakeCase
        let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
        return try decode(type, from: data)
    }
}

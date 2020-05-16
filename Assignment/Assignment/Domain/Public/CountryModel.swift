//
//  CountryModel.swift
//  Assignment
//
//  Created by Vandana Kanwar on 16/5/20.
//  Copyright © 2020 Vandana Kanwar. All rights reserved.
//

struct CountryModel: Codable {
    let title: String
    let rows: [Details]
}

struct Details: Codable {
    let title: String?
    let description: String?
    let imageHref: String?
}

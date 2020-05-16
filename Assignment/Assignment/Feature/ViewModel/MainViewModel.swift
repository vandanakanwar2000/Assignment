//
//  MainViewModel.swift
//  Assignment
//
//  Created by Vandana Kanwar on 16/5/20.
//  Copyright © 2020 Vandana Kanwar. All rights reserved.
//

import UIKit

class MainViewModel: NSObject {
    let service: CountryService
    
    let urlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    
    
    override init() {
        service = CountryService()
    }
    
    func fetchCountryInfo() {
        guard let url: URL = URL(string: urlString)
            else { return }
        service.fetch(url: url, result: CountryModel.self) { result in
            switch result {
            case .success: break
            //TODO: - Success Implementation
            case .failure: break
                //TODO: - Error Handling
                
            }
        }
    }
}

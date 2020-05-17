//
//  MainViewModel.swift
//  Assignment
//
//  Created by Vandana Kanwar on 16/5/20.
//  Copyright © 2020 Vandana Kanwar. All rights reserved.
//

import UIKit

protocol MainViewModelDelegates: AnyObject {
    func reloadView(details: [Details])
    func updateNavigationBarTitle(_ title: String)
    func showErrors(errorMessage: String)
    func updateCell(image: UIImage?, forIndex: IndexPath)
}

class MainViewModel: NSObject {
    let service: CountryService
    
    let urlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    
    weak var delegate: MainViewModelDelegates?
    
    override init() {
        service = CountryService()
    }
    
    func fetchCountryInfo() {
        guard let url: URL = URL(string: urlString)
            else { return }
        service.fetch(url: url, result: CountryModel.self) { result in
            switch result {
            case let .success(model):
                self.delegate?.updateNavigationBarTitle(model.title)
                
                let filteredArray = model.rows.filter { $0.description != nil
                    && $0.imageHref != nil
                    && $0.title != nil }
                self.delegate?.reloadView(details: filteredArray)
            case let .failure(error):
                
                guard let error = error as? ServiceError else { return }
                var errorMessage = ""
                switch error {
                case let .general(messsage):
                    errorMessage = messsage
                case .noNetwork:
                    errorMessage = "Please check your network settings"
                }
                
                self.delegate?.showErrors(errorMessage: errorMessage)
            }
        }
    }
    
    func fetchTileImage(imagePath: String, forIndex: IndexPath) {
        
        service.loadImage(imagePath: imagePath) { (image) in
            self.delegate?.updateCell(image: image, forIndex: forIndex)
            
        }
    }
}

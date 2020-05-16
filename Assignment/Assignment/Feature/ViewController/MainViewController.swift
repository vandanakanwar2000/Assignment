//
//  MainViewController.swift
//  Assignment
//
//  Created by Vandana Kanwar on 16/5/20.
//  Copyright © 2020 Vandana Kanwar. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    let viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        viewModel.delegate = self
        viewModel.fetchCountryInfo()
    }
    
}

extension MainViewController: MainViewModelDelegates {
    func showErrors(errorMessage: String) {
        //TODO: -
    }
    
    func updateNavigationBarTitle(_ title: String) {
        self.title = title
    }
    
    func reloadView(details: [Details]) {
        //TODO: -
    }

}

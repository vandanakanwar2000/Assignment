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
    var countryRows: [Details] = []
    var refreshCtrl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        viewModel.delegate = self
        viewModel.fetchCountryInfo()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(CountryInfoTableViewCell.self, forCellReuseIdentifier: "countryInfoTableViewCell")
        tableView.dataSource = self
        tableView.estimatedRowHeight = 144
        tableView.rowHeight = UITableView.automaticDimension
        
        refreshCtrl = UIRefreshControl()
        refreshCtrl.addTarget(self, action: #selector(MainViewController.refreshTableView),
                              for: .valueChanged)
        refreshControl = self.refreshCtrl
    }
    
    @objc func refreshTableView() {
        viewModel.fetchCountryInfo()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryRows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryInfoTableViewCell",
                                                 for: indexPath) as! CountryInfoTableViewCell
        cell.configureCell(countryRows[indexPath.row], nil)
        cell.selectionStyle = .none
        
        guard let imageName = countryRows[indexPath.row].imageHref
            else { return cell }
        
        viewModel.fetchTileImage(imagePath: imageName,
                                 forIndex: indexPath)
        
        return cell
    }
}

extension MainViewController: MainViewModelDelegates {
    func updateCell(image: UIImage?, forIndex: IndexPath) {
        
        if let activeCell = tableView.cellForRow(at: forIndex) as? CountryInfoTableViewCell {
            UIView.performWithoutAnimation {
                tableView.beginUpdates()
                activeCell.configureCell(countryRows[forIndex.row], image)
                tableView.endUpdates()
            }
        }
    }
    
    func showErrors(errorMessage: String) {
        countryRows = []
        tableView.reloadData()
        refreshControl?.endRefreshing()
        
        //TODO: - Show error in alert
    }
    
    func updateNavigationBarTitle(_ title: String) {
        self.title = title
    }
    
    func reloadView(details: [Details]) {
        countryRows = details
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
}

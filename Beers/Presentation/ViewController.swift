//
//  ViewController.swift
//  Beers
//
//  Created by Sergi Rojas on 19/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private struct Constants {
        static let cellIdentifier = "beer_list_cell"
        static let cellName = "BeerListCell"
    }
    
    var viewModel: BeerListViewModel?
    @IBOutlet var tableView: UITableView!
    

    
    override func viewDidLoad() {
        setupView()
    }
}


// MARK: - Setup View
extension ViewController {
    func setupView() {
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: Constants.cellName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
}

// MARK: - Tableview data source
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? BeerListTableViewCell, let beer =  self.viewModel?.items?[indexPath.row] {

            cell.setUp(beer: beer)
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - Tableview interactions
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelect(indexPath: indexPath)
        tableView.reloadData()
    }
}


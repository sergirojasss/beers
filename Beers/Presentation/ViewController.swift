//
//  ViewController.swift
//  Beers
//
//  Created by Sergi Rojas on 19/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel: BeerListViewModel?
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        setupView()
    }
}


// MARK: - Setup View
extension ViewController {
    func setupView() {
        tableView.register(UINib(nibName: "BeerListCell", bundle: nil), forCellReuseIdentifier: "beer_list_cell")
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "beer_list_cell", for: indexPath) as? BeerListTableViewCell else {
            return UITableViewCell()
        }
        cell.beer = self.viewModel?.items?[indexPath.row]
        return cell
    }
    
    
}

// MARK: - Tableview interactions
extension ViewController: UITableViewDelegate {
    
}


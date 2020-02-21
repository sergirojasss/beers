//
//  ViewController.swift
//  Beers
//
//  Created by Sergi Rojas on 19/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BeerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var beers: [Beer] = []
    var searchText: String = ""
    
    @IBOutlet var beerList: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.beerList.dataSource = self
        self.beerList.delegate = self
        self.searchBar.delegate = self
        
        BeerController.getBeers(vc: self) //I really think it's not the correct way to do it (passing de full vc), but I don't really remember how I use to do it
    }

    func gotBeers(beers: [Beer]) {
        self.beers = beers

        self.beerList.reloadData()
    }

//    - MARK: TableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        cell.textLabel?.text = beers[indexPath.row].name
        return cell
    }
    
    //    - MARK: SearchBar functions
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        BeerController.getBeers(vc: self, foodPairing: searchText)
    }
    
    @IBAction func changeOrder(_ sender: Any) {
        UserDefaults.standard.set(!UserDefaults.standard.bool(forKey: Constants.orderBeersBy), forKey: Constants.orderBeersBy)
        BeerController.getBeers(vc: self, foodPairing: self.searchText)
    }
    
}


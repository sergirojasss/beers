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
    @IBOutlet var orderByLabel: UILabel!
    @IBOutlet var orderByBtn: UIButton!
    @IBOutlet var orderByView: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = NSLocalizedString(ConstantsLocalizedStrings.navigationBarMainTitle, comment: "")
        
        self.beerList.dataSource = self
        self.beerList.delegate = self
        self.beerList.estimatedRowHeight = 70.0
        self.beerList.rowHeight = UITableView.automaticDimension
        self.beerList.keyboardDismissMode = .onDrag
        
        self.searchBar.delegate = self
        self.searchBar.placeholder = NSLocalizedString(ConstantsLocalizedStrings.foodPairingSearchbarPlaceholder, comment: "")
        
        self.orderByView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        self.orderByBtn.setImage(UIImage(named: "up"), for: .normal)
        self.orderByLabel.text = NSLocalizedString(ConstantsLocalizedStrings.orderByABV, comment: "")
        
//        BeerController.deleteAllBeers()
        BeerController.getBeers(vc: self) //I really think it's not the correct way to do it (passing de full vc), but I don't really remember how I use to do it
    }

    func gotBeers(beers: [Beer]) {
        self.beers = beers

        self.beerList.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        // should implement something to take care of the images memory
    }

//    - MARK: TableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: BeerListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "beer_list_cell") as? BeerListTableViewCell {
            cell.configCell(beer: beers[indexPath.row])
            return cell
        }
        return UITableViewCell() //never should happen, but just in case, the app doesn't crash
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as! BeerListTableViewCell).setSelectedCustom()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        // losing the selection on when interacting with the searchBar because it reloads the hole tableview from database, the way to solve it it's adding a bool field on database keeping the state
    }
    
    //    - MARK: SearchBar functions
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        BeerController.getBeers(vc: self, foodPairing: searchText)
    }
    
    @IBAction func changeOrder(_ sender: Any) {
        UserDefaults.standard.set(!UserDefaults.standard.bool(forKey: Constants.orderBeersBy), forKey: Constants.orderBeersBy)
        if UserDefaults.standard.bool(forKey: Constants.orderBeersBy) {
            self.orderByBtn.setImage(UIImage(named: "up"), for: .normal)
        } else {
            self.orderByBtn.setImage(UIImage(named: "down"), for: .normal)
        }
        BeerController.getBeers(vc: self, foodPairing: self.searchText)
    }
    
}


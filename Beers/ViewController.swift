//
//  ViewController.swift
//  Beers
//
//  Created by Sergi Rojas on 19/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    let beerController = BeerController()
    
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
        
        // main view customization
        self.title = NSLocalizedString(ConstantsLocalizedStrings.navigationBarMainTitle, comment: "")
        // main view customization
        
        // searchBar stuff
        self.searchBar.delegate = self
        self.searchBar.placeholder = NSLocalizedString(ConstantsLocalizedStrings.foodPairingSearchbarPlaceholder, comment: "")
        // searchBar stuff
        
        // table view
        self.beerList.dataSource = self
        self.beerList.delegate = self
        self.beerList.estimatedRowHeight = 70.0
        self.beerList.rowHeight = UITableView.automaticDimension
        self.beerList.keyboardDismissMode = .onDrag
        // table view
        
        // custom orderBy view stuff
        self.orderByView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        self.orderByBtn.setImage(UIImage(named: "up"), for: .normal)
        self.orderByLabel.text = NSLocalizedString(ConstantsLocalizedStrings.orderByABV, comment: "")
        // custom orderBy view stuff

        self.loadData()
    }

    func loadData(){
        
//        DispatchQueue.global(qos: .userInteractive).async {
//            BeerController.deleteAllBeers()
        beerController.getBeers(foodPairing: searchText, numBeers: beers.count) { (beers) in
                self.beers = beers
                self.beerList.reloadData()
                
        }
//        }
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
    
    var lastBeersCount: Int = -1
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == beers.count - 10 {
            if lastBeersCount != beers.count {
                lastBeersCount = beers.count
                loadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as! BeerListTableViewCell).setSelectedCustom()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        // losing the selection when interacting with the searchBar because it reloads the hole tableview from database, the way to solve it it's adding a bool field on database keeping the state
    }
    
    //    - MARK: SearchBar functions
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        beerController.getBeers(foodPairing: searchText) { (beers) in
            self.beers = beers
            self.beerList.reloadData()
        }
    }
    
    @IBAction func changeOrder(_ sender: Any) {
        // toggle boolean wich controls the orderBy
        UserDefaults.standard.set(!UserDefaults.standard.bool(forKey: Constants.orderBeersBy), forKey: Constants.orderBeersBy)
        
        // toggle orderBy image
        UserDefaults.standard.bool(forKey: Constants.orderBeersBy) ? self.orderByBtn.setImage(UIImage(named: "up"), for: .normal) : self.orderByBtn.setImage(UIImage(named: "down"), for: .normal)
        
        // call db or API to get results
        beerController.getBeers(foodPairing: searchText) { (beers) in
            self.beers = beers
            self.beerList.reloadData()
        }
    }
    
}


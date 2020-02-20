//
//  ViewController.swift
//  Beers
//
//  Created by Sergi Rojas on 19/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BeerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var beers: [Beer] = []
    
    @IBOutlet var beerList: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.beerList.dataSource = self
        self.beerList.delegate = self
        
//        BeerController.deleteAllBeers()
        BeerController.getBeers(vc: self) //I really think it's not the correct way to do it, but I don't really remember how I was doing it
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
    


}


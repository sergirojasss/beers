//
//  ViewController.swift
//  Beers
//
//  Created by Sergi Rojas on 19/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BeerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        BeerController.deleteAllBeers()
        BeerController.getBeers(vc: self, foodPairing: "Grilled_chicken_quesadilla") //I really think it's not the correct way to do it, but I don't really remember how I was doing it
    }

    func gotBeers(beers: [Beer]) {
        print(beers.count)
    }


}


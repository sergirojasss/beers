//
//  BeerController.swift
//  Beers
//
//  Created by Sergi Rojas on 19/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import Foundation
import SwiftyJSON


protocol BeerDelegate {
    func gotBeers(beers: [Beer])
}

// Relation between Entity Beer & DB
class BeerController {
    
    static func getBeers(vc: ViewController, foodPairing: String? = nil){
        let delegate: BeerDelegate?
        let db = AppDelegate.db
        delegate = vc
                
        let beers = db.read(foodPairing: foodPairing)
        //checking if we already have asked for beers, if not, we're calling the API with the method "getBeersRequest" also if we checked DB and there's no match, we're trying to find some result on the API
        if beers.count == 0 {
            self.getBeersRequest(vc: vc, foodPairing: foodPairing)
            print("Looking for results on Internet")
        } else {
            delegate?.gotBeers(beers: beers)
            print("Looking for results on DB")
        }
    }
    
    static func deleteAllBeers() {
        let db = AppDelegate.db
        db.deleteAllRows()
    }
    
    private static func getBeersRequest(vc: ViewController, foodPairing: String? = nil) {
        
        NetworkController.getBeersRequest(foodPairing: foodPairing) {beers in
            let delegate: BeerDelegate?
            delegate = vc
            delegate?.gotBeers(beers: beers)
        }
    }
}

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
        var condition = ""
        
        if foodPairing != nil {
            condition = "WHERE food_pairing LIKE '*\(foodPairing!)*'"
        }
//        checking if we already have asked for beers, if not, we're calling the API with the method "getBeersRequest"
        let beers = db.read(condition: condition)
        if beers.count == 0 { // we're assuming that Data from API never gets updated.
            self.getBeersRequest(vc: vc, foodPairing: foodPairing)
        } else {
            delegate?.gotBeers(beers: beers)
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

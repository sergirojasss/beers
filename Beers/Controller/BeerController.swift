//
//  BeerController.swift
//  Beers
//
//  Created by Sergi Rojas on 19/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import Foundation
import SwiftyJSON


// Relation between Entity Beer & DB
class BeerController {
    
    
    func getBeers(foodPairing: String? = nil, numBeers: Int = 0, completion: @escaping (_ success: [Beer]) -> Void){
        let db = DBHelper.shared

        var beers: [Beer]

        if foodPairing == nil {
            beers = db.readRealm()
        } else {
            beers = db.readRealm(foodPairing: foodPairing!)
        }
        
        if beers.count % Constants.APIpagination == 0 { //not working properly, but don't wanna lose time here.
            NetworkController.getBeersRequest(foodPairing: foodPairing, numBeers: numBeers) { (beers) in
                completion(beers.sorted(by: { (b1, b2) -> Bool in
                    if UserDefaults.standard.bool(forKey: Constants.orderBeersBy) {
                        return b1.abv < b2.abv
                    } else {
                        return b1.abv > b2.abv
                    }
                }))
            }
            print("Looking for results on Internet")
        } else {
            completion(beers.sorted(by: { (b1, b2) -> Bool in
                    if UserDefaults.standard.bool(forKey: Constants.orderBeersBy) {
                        return b1.abv < b2.abv
                    } else {
                        return b1.abv > b2.abv
                    }
                }))
            print("Looking for results on DB")
        }
    }
    
    static func deleteAllBeers() {
        let db = DBHelper.shared
        db.deleteAllRealm()
    }
    
}

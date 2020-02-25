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
    
    static var numBeers: Int = 0
    static var lastBeersCount: Int = 0
    
    static func getBeers(foodPairing: String? = nil, completion: @escaping (_ success: [Beer]) -> Void){
        let db = AppDelegate.db

        let beers = db.read(foodPairing: foodPairing)
        numBeers = beers.count
        //checking if we already have asked for beers, if not, we're calling the API with the method "getBeersRequest" also if we checked DB and there's no match, we're trying to find some result on the API
        if beers.isEmpty || numBeers == Constants.APIpagination {
            self.getBeersRequest(foodPairing: foodPairing, numBeers: numBeers)
            print("Looking for results on Internet")
        } else {
            completion(beers)
            print("Looking for results on DB")
        }
    }
    
    static func deleteAllBeers() {
        let db = AppDelegate.db
        db.deleteAllRows()
    }
    
    private static func getBeersRequest(foodPairing: String? = nil, numBeers: Int = 0) {

        NetworkController.getBeersRequest(foodPairing: foodPairing, numBeers: numBeers) {beers in
            if lastBeersCount != beers.count || beers.count == Constants.APIpagination {
                lastBeersCount = beers.count
                if beers.count % Constants.APIpagination == 0 {
                    self.getBeersRequest(foodPairing: foodPairing, numBeers: numBeers + Constants.APIpagination)
                }
            }
        }
    }
}

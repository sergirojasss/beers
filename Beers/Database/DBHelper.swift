//
//  DBHelper.swift
//  Beers
//
//  Created by Sergi Rojas on 19/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import Foundation
import RealmSwift


class BeerRealm: Object {
    @objc dynamic var id = -1
    @objc dynamic var name = ""
    @objc dynamic var tagline = ""
    @objc dynamic var imageURL = ""
    @objc dynamic var desc = ""
    @objc dynamic var abv = -1.0
    @objc dynamic var foodPairing: String = ""
    
    @objc dynamic var isSelected: Bool = false //hack for keeping selected the cell on the tableView
    
    override static func primaryKey() -> String? {
      return "id"
    }

}

class DBHelper
{
    
    static let shared: DBHelper = DBHelper.init()

    func insertOrUpdate(beer: Beer) {
        let realm = try! Realm()
        try! realm.write{
            let beerRealm = BeerRealm()
            beerRealm.id = beer.id
            beerRealm.name = beer.name
            beerRealm.tagline = beer.tagline
            beerRealm.imageURL = beer.imageURL
            beerRealm.desc = beer.description
            beerRealm.abv = beer.abv
            beerRealm.foodPairing = beer.foodPairing
            beerRealm.isSelected = beer.isSelected
            realm.add(beerRealm, update: .modified)
        }
    }
    
    func readRealm() -> [Beer] {
        let realm = try! Realm()
        let beersRealm = realm.objects(BeerRealm.self)
        var beers: [Beer] = []
        for beerRealm in beersRealm {
            beers.append(Beer(beerRealm: beerRealm))
        }
        return beers
    }
    
    func readRealm(foodPairing: String?) -> [Beer] {
        let realm = try! Realm()
        var food = foodPairing ?? ""
        if food.isEmpty {
            return readRealm()
        } else {
            food = foodPairing!
        }
        let beersRealm = realm.objects(BeerRealm.self).filter { (beerRealm) -> Bool in
            return beerRealm.foodPairing.lowercased().contains(food.lowercased())
        }
        var beers: [Beer] = []
        print(beersRealm.count)
        for beerRealm in beersRealm {
            beers.append(Beer(beerRealm: beerRealm))
        }
        return beers
    }

    
    func deleteAllRealm() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
  

    
}

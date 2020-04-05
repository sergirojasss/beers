//
//  BeerViewModel.swift
//  Beers
//
//  Created by Sergi Rojas on 02/04/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import UIKit

protocol BeerListModel {
    var items: [BeerModel]? {get set}
}

struct DefaultBeerListModel: BeerListModel  {
    
    var items: [BeerModel]?
    
    init(beers: [BeerModel]?) {
        self.items = beers
    }
}

struct BeerModel {
    let id: Int?
    let name: String?
    let tagline: String?
    let imageURL: String?
    let description: String?
    let abv: Double?
    let foodPairing: [String]?

    init(beer: BeerEntity) {
        self.id = beer.id
        self.name = beer.name
        self.tagline = beer.tagline
        self.imageURL = beer.imageURL
        self.description = beer.description
        self.abv = beer.abv
        self.foodPairing = beer.foodPairing
    }
}

//
//  Beer.swift
//  Beers
//
//  Created by Sergi Rojas on 19/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import Foundation

struct  BeerEntity {
    // Only using the attributes the app really needs. We could save as well all the other info of the API but it's useless right now.
    let id: Int?
    let name: String?
    let tagline: String?
    let imageURL: String?
    let description: String?
    let abv: Double?
    let foodPairing: [String]?
    
    var isSelected: Bool = false //hack for keeping selected the cell on the tableView
 
    init(beer: BeerRealm) {
        self.id = beer.id
        self.name = beer.name
        self.tagline = beer.tagline
        self.imageURL = beer.imageURL
        self.description = beer.description
        self.abv = beer.abv
        self.foodPairing = [beer.foodPairing] //just implementing the pattern. not caring about this right now
    }

}

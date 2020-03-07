//
//  Beer.swift
//  Beers
//
//  Created by Sergi Rojas on 19/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import Foundation

public class Beer {
    // Only using the attributes the app really needs. We could save as well all the other info of the API but it's useless right now.
    public let id: Int
    public let name: String
    public let tagline: String
    public let imageURL: String
    public let description: String
    public let abv: Double
    public let foodPairing: String //would be more clean if it's [String] but for what we want this field (compairing) it's works and it makes easier to code
    
    public var isSelected: Bool = false //hack for keeping selected the cell on the tableView
    
    
    public init(id: Int, name: String, tagline: String, imageURL: String, description: String, abv: Double, foodPairing: String) {
        self.id = id
        self.name = name
        self.tagline = tagline
        self.imageURL = imageURL
        self.description = description
        self.abv = abv
        self.foodPairing = foodPairing
    }
    
    init(beerRealm: BeerRealm) {
        self.id = beerRealm.id
        self.name = beerRealm.name
        self.tagline = beerRealm.tagline
        self.imageURL = beerRealm.imageURL
        self.description = beerRealm.desc
        self.abv = beerRealm.abv
        self.foodPairing = beerRealm.foodPairing
        self.isSelected = beerRealm.isSelected

    }
}

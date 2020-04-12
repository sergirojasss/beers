//
//  Beer.swift
//  Beers
//
//  Created by Sergi Rojas on 19/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import Foundation

struct  BeerEntity: Codable {
    // Only using the attributes the app really needs. We could save as well all the other info of the API but it's useless right now.
    let id: Int?
    let name: String?
    let tagline: String?
    let imageURL: String?
    let description: String?
    let abv: Double?
    let foodPairing: [String]?
    
    var isSelected: Bool = false //hack for keeping selected the cell on the tableView
 
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case tagline = "tagline"
        case imageURL = "image_url"
        case description
        case abv
        case foodPairing = "food_pairing"

    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        tagline = try values.decode(String.self, forKey: .tagline)
        imageURL = try values.decode(String.self, forKey: .imageURL)
        description = try values.decode(String.self, forKey: .description)
        abv = try values.decode(Double.self, forKey: .abv)
        foodPairing = try values.decode([String].self, forKey: .foodPairing)
    }

    
    init(beer: BeerRealm) {
        self.id = beer.id
        self.name = beer.name
        self.tagline = beer.tagline
        self.imageURL = beer.imageURL
        self.description = beer.desc
        self.abv = beer.abv
        self.foodPairing = [beer.foodPairing] //just implementing the pattern. not caring about this right now
    }
    
    

}

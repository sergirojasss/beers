//
//  BeerListViewModel.swift
//  Beers
//
//  Created by Sergi Rojas on 02/04/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import Foundation
import UIKit


protocol BeerListViewModel {
    var items: [BeerViewModel]? { get set }
    func viewDidLoad()
}

class DefaultBeerListViewModel: BeerListViewModel {
    
    var items: [BeerViewModel]?
    
    init(beers: [BeerViewModel]?) {
        self.items = beers
    }
    
    func viewDidLoad() {
        
    }
    
}

class BeerViewModel {
    let name: String?
    let tagline: String?
    let description: String?
    let abv: String?
    
    init(beer: BeerModel) {
        self.name = beer.name
        self.tagline = beer.tagline
        self.description = beer.description
        self.abv = String(format: "%.0f", beer.abv ?? 0)
    }
}

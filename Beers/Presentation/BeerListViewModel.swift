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
    func didSelect(indexPath: IndexPath)
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
    let id: Int?
    let name: String?
    let tagline: String?
    let description: String?
    let imageURL: String?
    let abv: String?
    var isSelected: Bool = false
    
    init(beer: BeerModel) {
        self.id = beer.id
        self.name = beer.name
        self.tagline = beer.tagline
        self.description = beer.description
        self.imageURL = beer.imageURL
        self.abv = String(format: "%.0f", beer.abv ?? 0)
    }
}

extension DefaultBeerListViewModel {
    func didSelect(indexPath: IndexPath) {
        items?[indexPath.row].isSelected.toggle()
    }
}

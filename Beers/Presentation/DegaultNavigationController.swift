//
//  DegaultNavigationController.swift
//  Beers
//
//  Created by Sergi Rojas on 05/04/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import Foundation
import UIKit

class DegaultNavigationController: UINavigationController {
    
    var beerController: BeerController = BeerController()
    var defaultBeerListModel: DefaultBeerListModel?
    var beerListViewModel: BeerListViewModel?
    
    override func viewDidLoad() {
        beerController.getBeers { (beerEntityArray) in
            let beers = beerEntityArray.map { BeerModel(beer: $0) }
            self.defaultBeerListModel = DefaultBeerListModel(beers: beers)
            
            let vmList = self.defaultBeerListModel?.items?.map { BeerViewModel(beer: $0) }
            
            let defaultBeerListViewModel = DefaultBeerListViewModel(beers: vmList)
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller: ViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            controller.viewModel = defaultBeerListViewModel
            
            self.show(controller, sender: self)
            
            
                        
        }
    }
    
}

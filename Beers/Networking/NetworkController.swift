//
//  NetworkController.swift
//  Beers
//
//  Created by Sergi Rojas on 19/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkController {
    
    static public let allBeersUrl: String = "https://api.punkapi.com/v2/beers"
    static public let id: String = "id"
    static public let name: String = "name"
    static public let tagline: String = "tagline"
    static public let description: String = "description"
    static public let imageUrl: String = "image_url"
    static public let abv: String = "abv"

    
    static func getBeers() {
        var beers: [Beer] = []
        var beer: Beer!
        
        AF.request(allBeersUrl, method: .get, parameters: nil)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json: JSON = JSON(value)
                    for (key, value) in json {
                        beer = Beer(id: value[id].stringValue, name: value[name].stringValue, tagline: value[tagline].stringValue, imageURL: value[imageUrl].stringValue, description: value[description].stringValue, abv: value[abv].doubleValue)
                        beers.append(beer)
                    }
                    print(beers.count)
                case .failure(let error): break
                    // error handling
                }
        }
        
    }
}

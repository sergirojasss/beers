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
    static public let foodPairing: String = "food_pairing"

    
    static func getBeersRequest(foodPairing: String?) {
        var beers: [Beer] = []
        var url = allBeersUrl
        
        if foodPairing != nil {
            url.append(contentsOf: "?&food=_\(foodPairing!)_")
        }
        
        AF.request(url, method: .get, parameters: nil)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json: JSON = JSON(value)
                    for (_, _) in json {
                        beers.append(jsonToBeerEntity(json: json))
                    }
                    if beers.count == 25 {
                        // must do something, we're not offering all the possible beers to customer
                        print("must do something, we're not offering all the possible beers to customer")
                    }
                    print(beers.count)
                case .failure(let error):
                    // error handling
                    print(error.errorDescription)
                    break
                }
        }
        
    }
    
    static func jsonToBeerEntity(json: JSON) -> Beer {
        return Beer(id: json[NetworkController.id].stringValue, name: json[NetworkController.name].stringValue, tagline: json[NetworkController.tagline].stringValue, imageURL: json[NetworkController.imageUrl].stringValue, description: json[NetworkController.description].stringValue, abv: json[NetworkController.abv].doubleValue, foodPairing: json[NetworkController.foodPairing].arrayValue.description)
    }
}

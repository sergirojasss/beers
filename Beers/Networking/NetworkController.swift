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
    
    
    static func getBeersRequest(foodPairing: String? = nil, numBeers: Int = 0, onCompletion: @escaping(([BeerEntity]) -> ())) {
        var url = allBeersUrl
        let db = DBHelper.shared

        
        if foodPairing != nil && !foodPairing!.isEmpty {
            url.append(contentsOf: "?&food=\(foodPairing!.replacingOccurrences(of: " ", with: "_"))")
        }

        if numBeers > 0 {
            url.append(contentsOf: "?page=\((numBeers/Constants.APIpagination)+1)")
            print(url)
        }
        
        AF.request(url, method: .get, parameters: nil)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json: JSON = JSON(value)
                    for (_, value) in json {
//                        DBHelper.shared.insertOrUpdate(beer: jsonToBeerEntity(json: value))
                    }
                    onCompletion(db.readRealm(foodPairing: foodPairing))
                case .failure(let error):
                    // error handling
                    print(error.errorDescription)
                    break
                }
        }
        
    }
    
//    static func jsonToBeerEntity(json: JSON) -> BeerEntity {
//        return BeerEntity(id: json[NetworkController.id].intValue, name: json[NetworkController.name].stringValue, tagline: json[NetworkController.tagline].stringValue, imageURL: json[NetworkController.imageUrl].stringValue, description: json[NetworkController.description].stringValue, abv: json[NetworkController.abv].doubleValue, foodPairing: json[NetworkController.foodPairing].arrayValue.description)
//    }
    
}

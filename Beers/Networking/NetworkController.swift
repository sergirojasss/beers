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
    
    
    static func getBeersRequest(foodPairing: String? = nil, onCompletion: @escaping(([Beer]) -> ())) {
        var beers: [Beer] = []
        var url = allBeersUrl
        let db = AppDelegate.db
        
        if foodPairing != nil && !foodPairing!.isEmpty {
            url.append(contentsOf: "?&food=\(foodPairing!.replacingOccurrences(of: " ", with: "_"))")
        }
        
        AF.request(url, method: .get, parameters: nil)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json: JSON = JSON(value)
                    for (_, value) in json {
                        beers.append(jsonToBeerEntity(json: value))
                    }
                    if beers.count == 25 {
                        // must do something, we're not offering all the possible beers to customer
                        print("must do something, we're not offering all the possible beers to customer")
                    }
                    for beer in beers {
                        db.insert(beer: beer)
                    }
                    onCompletion(db.read(foodPairing: foodPairing))
                case .failure(let error):
                    // error handling
                    print(error.errorDescription)
                    break
                }
        }
        
    }
    
    static func jsonToBeerEntity(json: JSON) -> Beer {
        return Beer(id: json[NetworkController.id].intValue, name: json[NetworkController.name].stringValue, tagline: json[NetworkController.tagline].stringValue, imageURL: json[NetworkController.imageUrl].stringValue, description: json[NetworkController.description].stringValue, abv: json[NetworkController.abv].doubleValue, foodPairing: json[NetworkController.foodPairing].arrayValue.description)
    }
    
}

extension UIImageView {
    
    func setPlaceholder() {
        self.image = UIImage(named: Constants.imagePlaceholder)
    }
    
    func downloaded(beerID: Int, from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        let beerImageName = "\(beerID)"
        if let savedImg: UIImage = self.getFromDevice(fileName: beerImageName) {
            self.image = savedImg
            return
        }
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            self.saveOnDevice(fileName: beerImageName, image: image)
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(beerID: Int, from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(beerID: beerID, from: url, contentMode: mode)
    }
    
    func saveOnDevice(fileName: String, image: UIImage) {
        // get the documents directory url
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // choose a name for your image
        let fileName = "\(fileName).png"
        // create the destination file url to save your image
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        // get your UIImage jpeg data representation and check if the destination file url already exists
        if let data = image.jpegData(compressionQuality:  1.0),
            !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                // writes the image data to disk
                try data.write(to: fileURL)
                print("file saved")
            } catch {
                print("error saving file:", error)
            }
        }
        
    }
    
    func getFromDevice(fileName: String) -> UIImage? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent("\(fileName).png")
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
            
        }
        return nil
    }
}


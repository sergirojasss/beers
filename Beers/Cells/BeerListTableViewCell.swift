//
//  BeerListTableViewCell.swift
//  Beers
//
//  Created by Sergi Rojas on 21/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import UIKit

class BeerListTableViewCell: UITableViewCell {
    
    var beer: Beer!
    
    @IBOutlet var name: UILabel!
    @IBOutlet var abv: UILabel!
    @IBOutlet var tagline: UILabel!
    @IBOutlet var beerImage: UIImageView!
    @IBOutlet var imageViewHeightConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        beerImage.setPlaceholder()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configCell(beer: Beer) {
        self.beer = beer
        
        name.text = beer.name
        abv.text = "\(NSLocalizedString(ConstantsLocalizedStrings.abv, comment: "")): \(beer.abv)%"
        tagline.text = beer.isSelected ? beer.description : beer.tagline
        
        imageViewHeightConstraint.constant = beer.isSelected ? 80 : 0
        beerImage.downloaded(beerID: beer.id, from: beer.imageURL)
    }
    
    func setSelectedCustom() {
        beer.isSelected.toggle()
    }
    
}

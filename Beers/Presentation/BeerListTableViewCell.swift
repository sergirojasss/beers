//
//  BeerListTableViewCell.swift
//  Beers
//
//  Created by Sergi Rojas on 21/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import UIKit

class BeerListTableViewCell: UITableViewCell {
    
    var beer: BeerViewModel? {
        didSet {
            name.text = beer?.name
            abv.text = beer?.abv
            tagline.text = beer?.isSelected ?? false ? beer?.description : beer?.tagline
//
            imageViewHeightConstraint.constant = beer?.isSelected ?? false ? 80 : 0
            beerImage.downloaded(beerID: beer?.id ?? 1, from: beer?.imageURL ?? "")
        }
    }
    
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
    
    func setUp(beer: BeerViewModel) {
        self.beer = beer
        configCell()
    }
    
    func configCell() {
        
        name.text = beer?.name
        abv.text = beer?.abv
        tagline.text = beer?.isSelected ?? false ? beer?.description : beer?.tagline
        
        imageViewHeightConstraint.constant = beer?.isSelected ?? false ? 80 : 0
    }
        
}

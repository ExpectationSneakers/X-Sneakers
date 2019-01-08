//
//  SizeViewCell.swift
//  ExpectationSneakers
//
//  Created by Edgar Barragan on 1/6/19.
//  Copyright © 2019 Brian Morales. All rights reserved.
//

import UIKit

class SizeViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sizeCellLabel: UILabel!
    
    func propiertiesSizeCell(){
        
        sizeCellLabel.layer.cornerRadius = 10.0
        sizeCellLabel.layer.borderWidth = 2.0
        sizeCellLabel.layer.borderColor = UIColor.black.cgColor
        //sizeCellLabel.layer.shadowColor = UIColor.black.cgColor
        //sizeCellLabel.layer.masksToBounds = true
    }
}

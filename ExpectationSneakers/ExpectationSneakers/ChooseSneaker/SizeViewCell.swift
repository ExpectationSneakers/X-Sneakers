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
    @IBOutlet weak var sizeLoadCellLabel: UILabel!
    
    func propiertiesSizeCell(label : UILabel){
        
        label.layer.cornerRadius = 10.0
        label.layer.borderWidth = 2.0
        //label.layer.borderColor = UIColor.white.cgColor
        //label.textColor = UIColor.white
        label.layer.borderColor = UIColor(displayP3Red: 0.678, green: 0.522, blue: 0.0, alpha: 1).cgColor
        label.textColor = UIColor(displayP3Red: 0.678, green: 0.522, blue: 0.0, alpha: 1)
        
        
        //sizeCellLabel.layer.shadowColor = UIColor.black.cgColor
        //sizeCellLabel.layer.masksToBounds = true
    }
}

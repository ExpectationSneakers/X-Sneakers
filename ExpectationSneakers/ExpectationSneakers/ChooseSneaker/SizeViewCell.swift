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
        label.layer.borderColor = UIColor.black.cgColor
        //sizeCellLabel.layer.shadowColor = UIColor.black.cgColor
        //sizeCellLabel.layer.masksToBounds = true
    }
}

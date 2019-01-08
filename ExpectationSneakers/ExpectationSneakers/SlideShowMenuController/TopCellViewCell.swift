//
//  CollectionViewCell.swift
//  ExpectationSneakers
//
//  Created by Edgar Barragan on 1/3/19.
//  Copyright © 2019 Brian Morales. All rights reserved.
//

import UIKit

class TopCellViewCell: UICollectionViewCell {
    
    @IBOutlet weak var topCellPhoto: UIImageView!
    
    
    func changeCorner(value: CGFloat){
        topCellPhoto.layer.cornerRadius = value
        topCellPhoto.layer.masksToBounds = true
    }
    
}

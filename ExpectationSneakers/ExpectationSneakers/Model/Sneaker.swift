//
//  Sneaker.swift
//  ExpectationSneakers
//
//  Created by Edgar Barragan on 1/3/19.
//  Copyright © 2019 Brian Morales. All rights reserved.
//

import UIKit

struct Sneaker{
    let name: String
    let image: UIImage
    let prices: Double
    let genre: String
    let description: String
    let sizes : [Size]
}

struct Size {
    let size: String
}


//
//  SneakerService.swift
//  ExpectationSneakers
//
//  Created by Edgar Barragan on 1/3/19.
//  Copyright © 2019 Brian Morales. All rights reserved.
//


import UIKit

class SneakerService {
    class func getSneakers(completion: @escaping ([Sneaker]) -> Void){
     
        let sneaker1 = Sneaker(name: "Corona", image: #imageLiteral(resourceName: "Puma"), prices: 25.5, description: "México")
        let sneaker2 = Sneaker(name: "Bohemia", image: #imageLiteral(resourceName: "Jordan4"), prices: 35.5, description: "México")
        let sneaker3 = Sneaker(name: "Indio", image: #imageLiteral(resourceName: "Versace"), prices: 35.5, description: "México")
        let sneaker4 = Sneaker(name: "Becks", image: #imageLiteral(resourceName: "Jordan3"), prices: 45.5, description: "Alemania")
        let sneaker5 = Sneaker(name: "Presidente", image: #imageLiteral(resourceName: "Jordan1"), prices: 65.5, description: "República Dominica")
        let sneaker6 = Sneaker(name: "Patito", image: #imageLiteral(resourceName: "Jordan4"), prices: 5.6, description: "México")
        let sneaker7 = Sneaker(name: "Budweiser", image: #imageLiteral(resourceName: "Jordan3"), prices: 75.5, description: "Checoslovaquia")
        
        
        let sneakersArray = [sneaker1, sneaker2, sneaker3, sneaker4, sneaker5, sneaker6, sneaker7]
        completion(sneakersArray)
    }
}

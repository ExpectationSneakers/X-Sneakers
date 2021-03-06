//
//  SneakerFirebase.swift
//  ExpectationSneakers
//
//  Created by Edgar Barragan on 1/13/19.
//  Copyright © 2019 Brian Morales. All rights reserved.
//

import Foundation
import Firebase

struct SneakerFirebase {
    
    let ref: DatabaseReference?
    let key: String
    let model: String
    let price: Double
    var brand: String
    let image64: String
    
    
    init(model: String, price: Double, brand: String, image: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.model = model
        self.price = price
        self.brand = brand
        self.image64 = image
       
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let model = value["model"] as? String,
            let price = value["price"] as? Double,
            let image = value["image"] as? String,
            let brand = value["brand"] as? String else {
                return nil
                
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.model = model
        self.price = price
        self.brand = brand
        self.image64 = image
    }
    
    func toAnyObject() -> Any {
        return [
            "model": model,
            "price": price,
            "brand": brand,
            "image": image64
        ]
    }
}








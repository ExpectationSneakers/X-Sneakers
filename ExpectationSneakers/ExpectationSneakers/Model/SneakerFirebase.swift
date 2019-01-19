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
    var description: String
    let image64: String
    
    init(model: String, price: Double, description: String, image: String,key: String = "") {
        self.ref = nil
        self.key = key
        self.model = model
        self.price = price
        self.description = description
        self.image64 = image
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let model = value["model"] as? String,
            let price = value["price"] as? Double,
            let image = value["image"] as? String,
            let description = value["description"] as? String else {
                return nil
                
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.model = model
        self.price = price
        self.description = description
        self.image64 = image
    }
    
    func toAnyObject() -> Any {
        return [
            "model": model,
            "price": price,
            "description": description,
            "image": image64
        ]
    }
}

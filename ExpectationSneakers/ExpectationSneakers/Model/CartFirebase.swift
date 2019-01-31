//
//  CartFirebase.swift
//  ExpectationSneakers
//
//  Created by Edgar Barragan on 1/27/19.
//  Copyright © 2019 Brian Morales. All rights reserved.
//

import Foundation
import Firebase

struct CartFirebase {
    
    let ref: DatabaseReference?
    let key: String
    let model: String
    let price: Double
    
    
    init(model: String, price: Double, key: String = "") {
        self.ref = nil
        self.key = key
        self.model = model
        self.price = price
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let model = value["model"] as? String,
            let price = value["price"] as? Double else {
                return nil
                
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.model = model
        self.price = price
    }
    
    func toAnyObject() -> Any {
        return [
            "model": model,
            "price": price,
        ]
    }
}

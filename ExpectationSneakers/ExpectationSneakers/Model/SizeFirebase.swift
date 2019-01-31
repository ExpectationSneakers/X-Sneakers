//
//  SizeFirebase.swift
//  ExpectationSneakers
//
//  Created by Edgar Barragan on 1/20/19.
//  Copyright © 2019 Brian Morales. All rights reserved.
//
import Foundation
import Firebase

struct SizeFirebase {
    
    let ref: DatabaseReference?
    let key: String
    let size: String
    var count: Int
    let sizeCM: String
    
    
    
    init(size: String, count: Int, sizeCM: String,key: String = "") {
        self.ref = nil
        self.key = key
        self.size = size
        self.count = count
        self.sizeCM = sizeCM
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let size = value["size"] as? String,
            let count = value["count"] as? Int,
            let sizeCM = value["sizeCM"] as? String else {
                return nil
                
        }
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.size = size
        self.count = count
        self.sizeCM = sizeCM
    }
    
    func toAnyObject() -> Any {
        return [
            "size": size,
            "count": count,
            "sizeCM": sizeCM
        ]
    }
}


//struct LocalSizes {
//    let size: String
//    let quantitySizesAvailable: Int
//}

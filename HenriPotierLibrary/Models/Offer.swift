//
//  Offer.swift
//  HenriPotierLibrary
//
//  Created by Ahmed K on 26/04/2017.
//  Copyright © 2017 Ahmed K. All rights reserved.
//

import Foundation

enum OfferType: String {
    case slice      = "slice"
    case percentage = "percentage"
    case minus      = "minus"
    
    
}
struct Offer {
    var type: OfferType
    var value: Float
    var slice: Float?
}

extension Offer {
    
    init?(_ dictionary: NSDictionary) {
        guard let typeString = dictionary["type"] as? String,
            let type =  OfferType(rawValue: typeString),
            let value = dictionary["value"] as? NSNumber else {
                return nil
        }
        
        //If the offer is slice then it must have the slice value or return nil
        if type == .slice {
            if let slice = dictionary["sliceValue"] as? NSNumber {
                self.slice = slice.floatValue
            } else {
                return nil
            }
        }
        
        self.type = type
        self.value = value.floatValue
    }
    
    func applyOfferAt(price: Float) -> Float {
        return 0
    }
    
}

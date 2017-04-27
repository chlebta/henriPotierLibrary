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
    
    //Calculate the price after applying the offer
    func applyOfferOn(price: Float) -> Float {
        switch self.type {
        case .minus:
            return price - value
        case .percentage:
            return (price / 100) * (100 - value)
        case .slice:
            return price - (floor(price / slice!) * value)
        }
    }
}

extension Offer {
    //This function will select best offer and apply it on given price
    //Inputs :
    //  offers => an of offers can be applied on the price
    //  price  =>  the price on which will apply the offer
    static func applyBestOffer(_ offers: [Offer], price: Float) -> Float {
        var bestPrice = price
        for offer in offers {
            let priceOfThisOffer = offer.applyOfferOn(price: price)
            if priceOfThisOffer < bestPrice {
                bestPrice = priceOfThisOffer
            }
        }
        return bestPrice
    }
}

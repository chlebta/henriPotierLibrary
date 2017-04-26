//
//  OfferApiManager.swift
//  HenriPotierLibrary
//
//  Created by Ahmed K on 26/04/2017.
//  Copyright © 2017 Ahmed K. All rights reserved.
//

import Foundation

typealias OffersResult = (_ offers: [Offer]?, _ error: Error?) -> Void

class OfferApiManager: ApiManager {
    
    //Hold the url for offers entry points
    var OfferAPIURL: String {
        get {
            return self.baseURl + "/books"
        }
    }

    
    func getOffersForCurrentPanel( _ withCompletion: OffersResult? = nil) {
        
        RequestManager(url: generateURL()).responseJSON { (response, error) in
            
            //For books the expected result is json array
            if let array = (response as? NSDictionary)?["offers"] as? [NSDictionary] {
                
                //Parse the received result to books array
                let offers:[Offer] = array.flatMap({ item -> Offer? in
                    return Offer(item)
                })
                
                withCompletion?(offers, nil)
            }
            else {
                withCompletion?(nil, ApiError.invalideResponse)
            }
        }
    }
    
    //This function will generate the offer url based on shared Pnnel
    fileprivate func generateURL() -> String {
    //http://henri-potier.xebia.fr/books/c8fabf68-8374-48fe-a7ea-a00ccd07afff,a460afed-e5e7-4e39-a39d-c885c05db861/commercialOffers
        
        
        let params: String = CartManager.shared.getIsbns().joined(separator: ",")
        return self.OfferAPIURL + "/" + params + "/commercialOffers"
    }
    
}

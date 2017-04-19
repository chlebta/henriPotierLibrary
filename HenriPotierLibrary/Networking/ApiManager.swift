//
//  ApiManager.swift
//  HenriPotierLibrary
//
//  Created by Ahmed K on 19/04/2017.
//  Copyright © 2017 Ahmed K. All rights reserved.
//

import Foundation

private let baseURl = "http://henri-potier.xebia.fr/"

enum ApiError: Error {
    case invalideResponse
    
    var description : String {
        switch self {
        case .invalideResponse:
            return NSLocalizedString("invalideResponse", comment: "Message to inform that received result is not as expected")
        }   
    }
}


class ApiManager {
}

// MARK: Books request
typealias BooksResult = (_ books: [Any]?, _ error: Error?) -> Void

extension ApiManager {
    
    static func getAllBooks( _ withCompletion: BooksResult? = nil) {
        RequestManager(url: "\(baseURl)/books").responseJSON { (response, error) in
            
            //For books the expected result is json array
            if let array = response as? [NSDictionary] {
                //Parse array to books array
                withCompletion?(array, nil)
                
                Log.debug("result : %@", array)
            }
            else {
                withCompletion?(nil, ApiError.invalideResponse)
            }
        }
    }

}


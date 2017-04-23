//
//  ApiManager.swift
//  HenriPotierLibrary
//
//  Created by Ahmed K on 19/04/2017.
//  Copyright © 2017 Ahmed K. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case invalideResponse
    
    var description : String {
        switch self {
        case .invalideResponse:
            return "Invalide server response"
        }   
    }
}


class ApiManager {

    let baseURl = "http://henri-potier.xebia.fr"

}



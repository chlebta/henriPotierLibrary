//
//  Book.swift
//  HenriPotierLibrary
//
//  Created by Ahmed K on 20/04/2017.
//  Copyright © 2017 Ahmed K. All rights reserved.
//

import Foundation


//Book structure
struct Book {
    
    var isbn: String
    var title: String
    var price: Float
    
    var coverUrl: String?
    var synopsis: [String]?
    
}

extension Book {
    init?(_ dictionary: NSDictionary) {
        return nil
    }
}

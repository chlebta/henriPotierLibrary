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

//MARK:
//MARK: Init
extension Book {
    
    init?(_ dictionary: NSDictionary) {
        
        guard let isbn = dictionary["isbn"] as? String,
            let title = dictionary["title"] as? String,
            let price = dictionary["price"] as? NSNumber else {
                return nil
        }
        
        self.isbn = isbn
        self.title = title
        self.price = price.floatValue

        self.coverUrl = dictionary["cover"] as? String
        self.synopsis = dictionary["synopsis"] as? [String]
    }
}

//MARK:
//MARK:
extension Book: Equatable {}

func ==(lhs: Book, rhs: Book) -> Bool {
    return lhs.isbn == rhs.isbn
}

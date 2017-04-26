//
//  BookModelView.swift
//  HenriPotierLibrary
//
//  Created by Ahmed K on 24/04/2017.
//  Copyright © 2017 Ahmed K. All rights reserved.
//

import Foundation

class BookModelView: CartItemModelView {
    
    fileprivate var book: Book
    
    var delegate: CartTableViewCellDelegate?
    var index: Int
    
    var title: String {
        get {
            return book.title
        }
    }
    var price: String {
        get {
            return book.price.asCurrency
        }
    }
    
    var imageURl: String? {
        get {
            return book.coverUrl
        }
    }
    
    
    init(_ book: Book, index: Int, delegate: CartTableViewCellDelegate?) {
        
        self.book = book
        self.index = index
        self.delegate = delegate
    }
    
}

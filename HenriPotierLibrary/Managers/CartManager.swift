//
//  CartManager.swift
//  HenriPotierLibrary
//
//  Created by Ahmed K on 23/04/2017.
//  Copyright © 2017 Ahmed K. All rights reserved.
//

import Foundation

final class CartManager {
    
    static let shared: CartManager = CartManager()
    
    public fileprivate(set) var cartItems: [Book]
    
    //Disable init from outside
    private init() {
        cartItems = []
    }
}

//MARK:
//MARK: cartItems funcs
extension CartManager {
    
    //add new item to cart
    func addItem( _ book: Book) {
        cartItems.append(book)
    }
    
    //Remove all occurance of given book
    func removeItem( _ book: Book) {
        let tempArray = cartItems.filter({ $0 != book})
        self.cartItems = tempArray
    }
    
    //Remove item in given index
    func removeItem(at: Int) {
        if index < cartItems.count {
            cartItems.remove(at: index)
        }
    }
    
}

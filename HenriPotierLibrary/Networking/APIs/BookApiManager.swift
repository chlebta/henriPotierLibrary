//
//  BookApiManager.swift
//  HenriPotierLibrary
//
//  Created by Ahmed K on 20/04/2017.
//  Copyright © 2017 Ahmed K. All rights reserved.
//

import Foundation

typealias BooksResult = (_ books: [Book]?, _ error: Error?) -> Void

class BookApiManager: ApiManager {
    
    //var to hold the url for books endpoints
    var bookAPIURL: String {
        get {
            return self.baseURl + "/books"
        }
    }
    
    
    //Get all books from the server.
    //Inputs: Optional completion block.

    func getAllBooks( _ withCompletion: BooksResult? = nil) {

        RequestManager(url: self.bookAPIURL).responseJSON { (response, error) in
            
            //For books the expected result is json array
            if let array = response as? [NSDictionary] {
                
                //Parse the received result to books array
                let books:[Book] = array.flatMap({ item -> Book? in
                    return Book(item)
                })
                
                withCompletion?(books, nil)
            }
            else {
                withCompletion?(nil, ApiError.invalideResponse)
            }
        }
    }
    
    
}

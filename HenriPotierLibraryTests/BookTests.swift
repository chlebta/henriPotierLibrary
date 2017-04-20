//
//  BookTests.swift
//  HenriPotierLibrary
//
//  Created by Ahmed K on 20/04/2017.
//  Copyright © 2017 Ahmed K. All rights reserved.
//

import XCTest
@testable import HenriPotierLibrary

class BookTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    //
    func testInitBookFromValidDictionary() {
        
        let testDictionary: NSDictionary =
            [
                "isbn": "c8fabf68-8374-48fe-a7ea-a00ccd07afff",
                "title": "Henri Potier à l'école des sorciers",
                "price": 35.0,
                "cover": "http://henri-potier.xebia.fr/hp0.jpg",
                "synopsis": ["synopsis-1", "synopsis-2"]
        ]
        
        let book = Book(testDictionary)
        
        XCTAssertNotNil(book)
        
        XCTAssertEqual(book?.isbn, "c8fabf68-8374-48fe-a7ea-a00ccd07afff")
        XCTAssertEqual(book?.title, "Henri Potier à l'école des sorciers")
        XCTAssertEqual(book?.price, 35)
        
        XCTAssertEqual(book?.coverUrl, "http://henri-potier.xebia.fr/hp0.jpg")
        
        XCTAssertEqual(book?.synopsis?.count, 2)
        XCTAssertEqual(book?.synopsis?.first, "synopsis-1")
        XCTAssertEqual(book?.synopsis?.last, "synopsis-2")
        
    }
    
    func testInitBookFromValidDictionary2() {
        
        let testDictionary: NSDictionary =
            [
                "isbn": "c8fabf68-8374-48fe-a7ea-a00ccd07afff",
                "title": "Henri Potier à l'école des sorciers",
                "price": 35
        ]
        
        let book = Book(testDictionary)
        
        XCTAssertNotNil(book)
        
        XCTAssertEqual(book?.isbn, "c8fabf68-8374-48fe-a7ea-a00ccd07afff")
        XCTAssertEqual(book?.title, "Henri Potier à l'école des sorciers")
        XCTAssertEqual(book?.price, 35.0)
        
        XCTAssertNil(book?.coverUrl)
    }
    
    
    func testInitBookFromInvalidDictionary() {
        
        //The isbn code is missing
        let testDictionary: NSDictionary =
            [
                "title": "Henri Potier à l'école des sorciers",
                "price": 35,
                "cover": "http://henri-potier.xebia.fr/hp0.jpg",
                "synopsis": ["synopsis-1", "synopsis-2"]
        ]
        
        let book = Book(testDictionary)
        
        XCTAssertNil(book)
    }
    
    func testInitBookWithInvalidPrice() {
        
        //The price is string
        let testDictionary1: NSDictionary =
            [
                "isbn": "c8fabf68-8374-48fe-a7ea-a00ccd07afff",
                "title": "Henri Potier à l'école des sorciers",
                "price": "35",
                "cover": "http://henri-potier.xebia.fr/hp0.jpg",
                "synopsis": ["synopsis-1", "synopsis-2"]
        ]
        
        XCTAssertNil(Book(testDictionary1))
        
        //the price is missing
        
        let testDictionary2: NSDictionary =
            [
                "isbn": "c8fabf68-8374-48fe-a7ea-a00ccd07afff",
                "title": "Henri Potier à l'école des sorciers",
                "cover": "http://henri-potier.xebia.fr/hp0.jpg",
                "synopsis": ["synopsis-1", "synopsis-2"]
        ]
        
        XCTAssertNil(Book(testDictionary2))
    }
    
}

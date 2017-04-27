//
//  OfferTests.swift
//  HenriPotierLibrary
//
//  Created by Ahmed K on 26/04/2017.
//  Copyright © 2017 Ahmed K. All rights reserved.
//

import XCTest
@testable import HenriPotierLibrary

class OfferTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
}

//MARK: Init tests
extension OfferTests {
    func testInitPercentageOffer() {
        
        let testDictionary: NSDictionary = ["type": "percentage", "value": 5]
        
        let offer = Offer(testDictionary)
        
        XCTAssertNotNil(offer)
        
        XCTAssertEqual(offer?.value, 5)
        XCTAssertEqual(offer?.type, OfferType.percentage)
    }
    
    func testInitMinusOffer() {
        
        let testDictionary: NSDictionary = ["type": "minus", "value": 15]
        
        let offer = Offer(testDictionary)
        
        XCTAssertNotNil(offer)
        XCTAssertEqual(offer?.value, 15)
        XCTAssertEqual(offer?.type, OfferType.minus)
    }
    
    func testInitSliceOffer() {
        
        let testDictionary: NSDictionary = ["type": "slice", "sliceValue": 100, "value": 12]
        
        let offer = Offer(testDictionary)
        XCTAssertNotNil(offer)
        XCTAssertEqual(offer?.value, 12)
        XCTAssertEqual(offer?.slice, 100)
        XCTAssertEqual(offer?.type, OfferType.slice)
    }
    
    func testInitInvalidSliceOffer() {
        
        let testDictionary: NSDictionary = ["type": "slice", "value": 12]
        
        let offer = Offer(testDictionary)
        XCTAssertNil(offer)
    }
    
    func testInitUnknowOffer() {
        
        let testDictionary: NSDictionary = ["type": "sum", "value": 12]
        
        let offer = Offer(testDictionary)
        XCTAssertNil(offer)
    }
}

//MARK: Calculator tests
extension OfferTests {
  
    func testOfferPercentCalulator() {
        
        let testDictionary: NSDictionary = ["type": "percentage", "value": 5]
        
        let offer = Offer(testDictionary)
        XCTAssertNotNil(offer)
        
        let priceAfterApplyingTheOffer = offer?.applyOfferOn(price: 100)
        XCTAssertEqual(priceAfterApplyingTheOffer, 95)

    }
    
    func testOfferMinusCalulator() {
        
        let testDictionary: NSDictionary = ["type": "minus", "value": 15]
        
        let offer = Offer(testDictionary)
        XCTAssertNotNil(offer)
        
        let priceAfterApplyingTheOffer = offer?.applyOfferOn(price: 100)
        XCTAssertEqual(priceAfterApplyingTheOffer, 85)
        
    }
    
    func testOfferSliceCalulator() {
        
        let testDictionary: NSDictionary = ["type": "slice", "sliceValue": 100, "value": 12]
        
        let offer = Offer(testDictionary)
        XCTAssertNotNil(offer)
        
        let priceAfterApplyingTheOffer = offer?.applyOfferOn(price: 100)
        XCTAssertEqual(priceAfterApplyingTheOffer, 88)
        
    }
    
    func testOfferSliceCalulator2() {
        
        let testDictionary: NSDictionary = ["type": "slice", "sliceValue": 200, "value": 12]
        
        let offer = Offer(testDictionary)
        XCTAssertNotNil(offer)
        
        let priceAfterApplyingTheOffer = offer?.applyOfferOn(price: 100)
        XCTAssertEqual(priceAfterApplyingTheOffer, 100)
        
    }
    
    func testOfferSliceCalulator3() {
        
        let testDictionary: NSDictionary = ["type": "slice", "sliceValue": 100, "value": 12]
        
        let offer = Offer(testDictionary)
        XCTAssertNotNil(offer)
        
        let priceAfterApplyingTheOffer = offer?.applyOfferOn(price: 350)
        XCTAssertEqual(priceAfterApplyingTheOffer, 314)
    }
    
}

//MARK: Best offer getter
extension OfferTests {
    
    func testApplyBestOffer() {
        
        let offer1 = Offer(["type": "slice", "sliceValue": 100, "value": 12])
        let offer2 = Offer(["type": "minus", "value": 15])
        let offer3 = Offer(["type": "percentage", "value": 5])
        let price:Float = 65

        let priceAfterOffer = Offer.applyBestOffer([offer1!, offer2!, offer3!], price: price)
        XCTAssertEqual(priceAfterOffer, 50)

    }
}


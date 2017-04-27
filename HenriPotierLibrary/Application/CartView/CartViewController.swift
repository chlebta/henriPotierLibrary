//
//  CartViewController.swift
//  HenriPotierLibrary
//
//  Created by Ahmed K on 23/04/2017.
//  Copyright © 2017 Ahmed K. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var reuseIdentifier:String = "cartCell"

    @IBOutlet weak var totalPrice: UILabel!
    
    var priceBeforeDiscount = CartManager.shared.getTotalItemsPrice()
    var priceAfterDiscount: Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.getOffers()
        
    }


}

//MARK:
//MARK: Configure views
extension CartViewController {
    
    fileprivate func setupViews() {
        
        self.title = "Cart items"
        
        //Tableview customization
        self.tableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        
        self.refreshPriceLabel()

    }
}

//MARK:

//MARK:
//MARK: tableview
extension CartViewController: UITabBarDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return CartManager.shared.cartItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CartTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! CartTableViewCell
        
        let index = indexPath.section
        let book = CartManager.shared.cartItems[index]
        cell.item = BookModelView(book, index: index, delegate: self)
        return cell
    }
}

//MARK:
//MARK:
extension CartViewController {
    fileprivate func getOffers() {
        
        self.priceBeforeDiscount = CartManager.shared.getTotalItemsPrice()
        OfferApiManager().getOffersForCurrentPanel { (result, error) in
            if let offers = result {
                self.priceAfterDiscount = Offer.applyBestOffer(offers, price: self.priceBeforeDiscount)
                self.refreshPriceLabel()
            }
        }
    }
    
    fileprivate func refreshPriceLabel() {
        
        if self.priceAfterDiscount == self.priceBeforeDiscount || priceAfterDiscount == nil {
            self.totalPrice.text = "To pay : \(priceBeforeDiscount)"
            return
        }
        
        let attributedString   =  NSMutableAttributedString(string: "To pay: ", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 17), NSForegroundColorAttributeName: UIColor.white])
        
        attributedString.append(
            NSMutableAttributedString(string: "\(priceBeforeDiscount)",
                attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 17),
                             NSForegroundColorAttributeName: UIColor.white,
                             NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue,
                             NSStrikethroughColorAttributeName: UIColor.red])
        )
        
        attributedString.append(NSAttributedString(string: " "))
        
        attributedString.append(NSAttributedString(string: "\(priceAfterDiscount!)",
            attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 24),
                         NSForegroundColorAttributeName: UIColor.red]))
        
        totalPrice.attributedText = attributedString
    }
}

//MARK:
//MARK: CartCell delegates
extension CartViewController: CartTableViewCellDelegate {
    
    //User did delete an item
    func didRemoveItem() {
        self.getOffers()
        
        self.tableView.reloadData()
        
    }
}

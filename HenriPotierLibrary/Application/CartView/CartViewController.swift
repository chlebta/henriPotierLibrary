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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        
        OfferApiManager().getOffersForCurrentPanel { (result, error) in
            print(result)
        }
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
//MARK: CartCell delegates
extension CartViewController: CartTableViewCellDelegate {
    
    //User did delete an item
    func didRemoveItem() {
        self.tableView.reloadData()
    }
}

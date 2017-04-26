//
//  CartTableViewCell.swift
//  HenriPotierLibrary
//
//  Created by Ahmed K on 23/04/2017.
//  Copyright © 2017 Ahmed K. All rights reserved.
//

import UIKit

//MARK: cart item protocol
protocol CartItemModelView {
    
    var index: Int {get}
    var delegate: CartTableViewCellDelegate? {get}
    
    var title: String { get }
    var price: String  {get}
    var imageURl: String? { get }
    
}

//MARK: delagates protocol
protocol CartTableViewCellDelegate {
    func didRemoveItem()
}


class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    var item: CartItemModelView! {
        didSet {
            self.reloadViews()
        }
    }

    fileprivate func reloadViews() {
        
        self.titleLabel.text = item.title
        self.priceLabel.text = item.price
        
        if let url = item.imageURl {
            self.coverImageView.imageFromUrl(url, UIImage(named: "cover"))
        }
    }
    
    
    @IBAction func removeAction(_ sender: Any) {
        CartManager.shared.removeItem(at: item.index)
        item.delegate?.didRemoveItem()
    }
    
}

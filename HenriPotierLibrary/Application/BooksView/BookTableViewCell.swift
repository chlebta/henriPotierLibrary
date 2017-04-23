//
//  BookTableViewCell.swift
//  HenriPotierLibrary
//
//  Created by Ahmed K on 20/04/2017.
//  Copyright © 2017 Ahmed K. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var book: Book! {
        didSet {
            self.reloadView()
        }
    }
    
    
    fileprivate func reloadView() {
        self.priceLabel.text = book.price.asCurrency
        self.titleLabel.text = book.title
        
        if let url = book.coverUrl {
            self.coverImageView.imageFromUrl(url, UIImage(named: "cover"))
        }
    }
}

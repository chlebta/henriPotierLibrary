//
//  BooksViewController.swift
//  HenriPotierLibrary
//
//  Created by Ahmed K on 20/04/2017.
//  Copyright © 2017 Ahmed K. All rights reserved.
//

import UIKit

class BooksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate var reuseIdentifier:String = "bookCell"

    fileprivate var books: [Book] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        getData()
    }

}

//MARK:
//MARK: Configure views
extension BooksViewController {
    
    //Her goes any views costumization
    fileprivate func setupViews() {
        
        self.title = "Books list"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"bag"), style: .plain, target: self, action: #selector(self.openShoppingView(_ :)))
            
        //Tableview customization
        self.tableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
    }
}

//MARK:
//MARK: server calls handlers
extension BooksViewController {
    
    //Get books from server
    fileprivate func getData() {
       
        BookApiManager().getAllBooks { (result, error) in
            if let books = result,
                error == nil {
                
                self.books = books
                self.tableView.reloadData()
            }
        }
    }
    
}

//MARK: 
//MARK: Actions 
extension BooksViewController {
    @objc fileprivate func openShoppingView( _ sender: Any) {
        self.performSegue(withIdentifier: "cartSegue", sender: self)
    }
}

//MARK:
//MARK: tableview
extension BooksViewController: UITabBarDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let cell:BookTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! BookTableViewCell
    
        cell.book = books[indexPath.section]
        cell.index = indexPath.section
        cell.delegate = self
        return cell
    }
    
}

//MARK:
//MARK: BookCellDelegate
extension BooksViewController: BookTableViewCellDelegate {
    func didTapAddButton(_ index: Int) {
        self.navigationItem.rightBarButtonItem?.badgeValue = "\(CartManager.shared.cartItems.count)"
    }
    
}

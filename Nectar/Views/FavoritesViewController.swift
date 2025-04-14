//
//  FavoritesViewController.swift
//  Nectar
//
//  Created by Mayank Jangid on 4/11/25.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addAllToCartButton: UIButton!
    
    var favoriteItems: [FavoriteItem] {
        return FavoriteManager.shared.favoriteItems
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite"
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // MARK: - Actions
    @IBAction func addAllToCartTapped(_ sender: UIButton) {
        // For each favorite, add it to the cart (with a default quantity of 1)
        for fav in favoriteItems {
            CartManager.shared.addProduct(fav.product, quantity: 1)
        }
        print("Added \(favoriteItems.count) favorites to cart. Total cart items: \(CartManager.shared.cartItems.count)")
    }
}

// MARK: - UITableView Data Source & Delegate

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return favoriteItems.count
    }
    
    // Configure the Favorite Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? FavoriteCell else {
            return UITableViewCell()
        }
        
        let favItem = favoriteItems[indexPath.row]
        cell.configure(with: favItem)
        
        // will add remove if needed .... abhi soch rha hui mei
//        // Remove action when cross tapped
//        cell.onRemoveTapped = { [weak self] in
//            FavoriteManager.shared.removeFavorite(favItem.product)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UIScreen.main.bounds.height / 6
        }
}

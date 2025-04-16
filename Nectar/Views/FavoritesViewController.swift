//
//  FavoritesViewController.swift
//  Nectar
//
//  Created by Mayank Jangid on 4/11/25.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addAllToCartButton: UIButton!
    
    @IBOutlet weak var emptyStateView: UIView!
    
    var favoriteItems: [FavoriteItem] {
        return FavoriteManager.shared.favoriteItems
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite"
        tableView.delegate = self
        tableView.dataSource = self
        
        // Initially, hide the table view’s background.
        tableView.backgroundView = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        updateEmptyState()
    }
    
    // MARK: - Actions
    @IBAction func addAllToCartTapped(_ sender: UIButton) {
        // For each favorite, add it to the cart (with a default quantity of 1)
        for fav in favoriteItems {
            CartManager.shared.addProduct(fav.product, quantity: 1)
        }
        print("Added \(favoriteItems.count) favorites to cart. Total cart items: \(CartManager.shared.cartItems.count)")
    }
    
    // IBAction for the Explore button from the empty state view.
    @IBAction func exploreButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let exploreVC = storyboard.instantiateViewController(withIdentifier: "ExploreViewController") as? ExploreViewController {
            navigationController?.pushViewController(exploreVC, animated: true)
        }
    }
    
    // MARK: - Helper Methods
    private func updateEmptyState() {
        if favoriteItems.isEmpty {
            // Set the emptyStateView as the background view of the table view
            // Make sure it's not hidden in the Storyboard!
            tableView.backgroundView = emptyStateView
            // Optionally hide cell separators
            tableView.separatorStyle = .none
            
            addAllToCartButton.isHidden = true
        } else {
            // Remove the background view so that cells appear normally.
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
            
            addAllToCartButton.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a reusable cell of type FavoriteCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? FavoriteCell else {
            return UITableViewCell()
        }
        
        // Get the favorite item corresponding to this row
        let favItem = favoriteItems[indexPath.row]
        
        // Configure the cell using your custom configure method
        cell.configure(with: favItem)
        
        return cell
    }

}

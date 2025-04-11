//
//  CartViewController.swift
//  Nectar
//
//  Created by Mayank Jangid on 4/11/25.
//

import UIKit

class CartViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutButton: UIButton! // Assume a button at the bottom

    // MARK: - Data Source
    // Use the CartManager's shared instance for current cart items.
    var cartItems: [CartItem] {
        return CartManager.shared.cartItems
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My cart"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // (Optional) Set table view separator style or custom separator if needed.
    }
    
    // MARK: - Actions
    @IBAction func checkoutTapped(_ sender: UIButton) {
        // For now, simply print the cart summary
        print("Checkout pressed. Total items in cart: \(CartManager.shared.cartItems.count)")
    }
}

// MARK: - UITableView Data Source & Delegate

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    // Configure the Cart Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // In CartViewController.swift inside cellForRowAt:
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartCell else {
            return UITableViewCell()
        }
        let cartItem = cartItems[indexPath.row]
        cell.configure(with: cartItem)
        
        // When minus is tapped, update the model with the new quantity.
        cell.onMinusTapped = { [weak self] (newQuantity: Int) in
            guard let self = self else { return }
            var updatedItem = self.cartItems[indexPath.row]
            updatedItem.quantity = newQuantity
            CartManager.shared.cartItems[indexPath.row] = updatedItem
            print("New quantity after minus: \(newQuantity)")
        }

        cell.onPlusTapped = { [weak self] (newQuantity: Int) in
            guard let self = self else { return }
            var updatedItem = self.cartItems[indexPath.row]
            updatedItem.quantity = newQuantity
            CartManager.shared.cartItems[indexPath.row] = updatedItem
            print("New quantity after plus: \(newQuantity)")
        }
        
        // Remove closure remains as is.
        cell.onRemoveTapped = { [weak self] in
            guard let self = self else { return }
            CartManager.shared.cartItems.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return max(160, tableView.frame.height / 6)
    }

}

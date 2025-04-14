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
    @IBOutlet weak var checkoutButton: UIButton!

    // MARK: - Data Source
    var cartItems: [CartItem] {
        return CartManager.shared.cartItems
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My cart"
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        updateCheckoutButtonTitle()
    }
    
    
    // MARK: - Actions
    @IBAction func checkoutTapped(_ sender: UIButton) {
        print("Checkout pressed. Total items in cart: \(CartManager.shared.cartItems.count)")
    }
    
    //to calc total
    private func updateCheckoutButtonTitle() {
        let total = CartManager.shared.cartItems.reduce(0.0) { result, item in
            return result + (item.product.price * Double(item.quantity))
        }
        let formattedTotal = String(format: "$%.2f", total)
        checkoutButton.setTitle("Go to checkout (\(formattedTotal))", for: .normal)
    }
    
}

// MARK: - UITableView Data Source & Delegate

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    // config cart cell...
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartCell else {
            return UITableViewCell()
        }
        let cartItem = cartItems[indexPath.row]
        cell.configure(with: cartItem)
        
        cell.onMinusTapped = { [weak self] (newQuantity: Int) in
            guard let self = self else { return }
            var updatedItem = self.cartItems[indexPath.row]
            updatedItem.quantity = newQuantity
            CartManager.shared.cartItems[indexPath.row] = updatedItem
            print("New quantity after minus: \(newQuantity)")
            updateCheckoutButtonTitle()
        }

        cell.onPlusTapped = { [weak self] (newQuantity: Int) in
            guard let self = self else { return }
            var updatedItem = self.cartItems[indexPath.row]
            updatedItem.quantity = newQuantity
            CartManager.shared.cartItems[indexPath.row] = updatedItem
            print("New quantity after plus: \(newQuantity)")
            updateCheckoutButtonTitle()
        }
        
        cell.onRemoveTapped = { [weak self] in
            guard let self = self else { return }
            CartManager.shared.cartItems.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            updateCheckoutButtonTitle()
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return max(160, tableView.frame.height / 6)
    }

}

//
//  CartViewController.swift
//  Nectar
//
//  Created by Mayank Jangid on 4/11/25.
//

import UIKit

//Note for practice i did the empty screen state thing progrmamtically but rest of the things are via storyboard and in fav screen everything is via storyboard.... it was just done out of curiousity ... no logic behind it

class CartViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutButton: UIButton!
    
    // A property to hold our empty state view so we can remove it when needed.
    private var emptyStateView: UIView?
    
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
        
        updateEmptyState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        updateCheckoutButtonTitle()
        updateEmptyState()
    }
    
    // MARK: - Actions
    @IBAction func checkoutTapped(_ sender: UIButton) {
        print("Checkout pressed. Total items in cart: \(CartManager.shared.cartItems.count)")
        
        let checkoutSheetVC = CheckoutBottomSheetViewController()
        // Use .overFullScreen or .overCurrentContext so that the semi-transparent background shows.
        checkoutSheetVC.modalPresentationStyle = .overFullScreen
        checkoutSheetVC.modalTransitionStyle = .coverVertical
        present(checkoutSheetVC, animated: true, completion: nil)
    }
    
    // MARK: - Helper Methods
    
    private func updateCheckoutButtonTitle() {
        let total = CartManager.shared.cartItems.reduce(0.0) { result, item in
            return result + (item.product.price * Double(item.quantity))
        }
        let formattedTotal = String(format: "$%.2f", total)
        checkoutButton.setTitle("Go to checkout (\(formattedTotal))", for: .normal)
    }
    
    /// If there are no items in the cart, set a background view on the table view
    /// with a message and a button to go to the Explore screen.
    private func updateEmptyState() {
        if cartItems.isEmpty {
            if emptyStateView == nil {
                let emptyView = UIView(frame: tableView.bounds)
                emptyView.backgroundColor = .clear
                
                let messageLabel = UILabel()
                messageLabel.text = "Your cart is empty. Add something first."
                messageLabel.textAlignment = .center
                messageLabel.numberOfLines = 0
                messageLabel.translatesAutoresizingMaskIntoConstraints = false
                emptyView.addSubview(messageLabel)
                
                let exploreButton = UIButton(type: .system)
                exploreButton.setTitle("Explore", for: .normal)
                exploreButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                exploreButton.translatesAutoresizingMaskIntoConstraints = false
                exploreButton.addTarget(self, action: #selector(navigateToExplore), for: .touchUpInside)
                emptyView.addSubview(exploreButton)
                
                // Layout constraints
                NSLayoutConstraint.activate([
                    messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
                    messageLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20),
                    messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: emptyView.leadingAnchor, constant: 16),
                    messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: emptyView.trailingAnchor, constant: -16),
                    
                    exploreButton.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
                    exploreButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20)
                ])
                
                emptyStateView = emptyView
            }
            
            tableView.backgroundView = emptyStateView
            tableView.separatorStyle = .none
        } else {
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
            emptyStateView = nil
        }
    }
    
    @objc private func navigateToExplore() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let exploreVC = storyboard.instantiateViewController(withIdentifier: "ExploreViewController") as? ExploreViewController {
            navigationController?.pushViewController(exploreVC, animated: true)
        }
    }
}

// MARK: - UITableView Data Source & Delegate

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
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
            self.updateCheckoutButtonTitle()
        }

        cell.onPlusTapped = { [weak self] (newQuantity: Int) in
            guard let self = self else { return }
            var updatedItem = self.cartItems[indexPath.row]
            updatedItem.quantity = newQuantity
            CartManager.shared.cartItems[indexPath.row] = updatedItem
            print("New quantity after plus: \(newQuantity)")
            self.updateCheckoutButtonTitle()
        }
        
        cell.onRemoveTapped = { [weak self] in
            guard let self = self else { return }
            CartManager.shared.cartItems.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.updateCheckoutButtonTitle()
            self.updateEmptyState()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return max(160, tableView.frame.height / 6)
    }
}

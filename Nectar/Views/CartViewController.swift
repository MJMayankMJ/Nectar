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
    
    // A property to hold our empty state view so we can remove it when needed.
    private var emptyStateView: UIView?
    
    // MARK: - Data Source
    var cartItems: [CartItem] {
        return CartManager.shared.cartItems
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Cart"
    
        
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
        let checkoutSheetVC = CheckoutBottomSheetViewController()
        checkoutSheetVC.modalPresentationStyle = .overFullScreen
        checkoutSheetVC.modalTransitionStyle = .coverVertical
        present(checkoutSheetVC, animated: true, completion: nil)
    }
    
    // MARK: - Helper Methods
    private func updateCheckoutButtonTitle() {
        let total = cartItems.reduce(0.0) { $0 + ($1.product.price * Double($1.quantity)) }
        let formattedTotal = String(format: "$%.2f", total)
        checkoutButton.setTitle("Go to checkout (\(formattedTotal))", for: .normal)
    }
    
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
                exploreButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
                exploreButton.translatesAutoresizingMaskIntoConstraints = false
                exploreButton.addTarget(self, action: #selector(navigateToExplore), for: .touchUpInside)
                emptyView.addSubview(exploreButton)
                
                NSLayoutConstraint.activate([
                    messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
                    messageLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20),
                    messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: emptyView.leadingAnchor, constant: 16),
                    messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: emptyView.trailingAnchor, constant: -16),
                    
                    exploreButton.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
                    exploreButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20)
                ])
                
                checkoutButton.isHidden = true
                emptyStateView = emptyView
            }
            tableView.backgroundView = emptyStateView
            tableView.separatorStyle = .none
        } else {
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
            emptyStateView = nil
            checkoutButton.isHidden = false
        }
    }
    
    @objc private func navigateToExplore() {
        guard let tabBar = self.tabBarController,
              let vcs = tabBar.viewControllers,
              vcs.count > 3,
              let targetNav = vcs[3] as? UINavigationController
        else { return }
        
        // Pop that tab’s nav to its root
        targetNav.popToRootViewController(animated: false)
        
        // Smoothly switch tabs
        UIView.transition(
            from: view!,
            to: targetNav.view,
            duration: 0.25,
            options: [.transitionCrossDissolve, .showHideTransitionViews]
        ) { _ in
            tabBar.selectedIndex = 3
        }
    }
}

// MARK: - UITableView Data Source & Delegate

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tv: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tv: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tv.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartCell else {
            return UITableViewCell()
        }
        let item = cartItems[indexPath.row]
        cell.configure(with: item)
        
        cell.onMinusTapped = { [weak self] newQty in
            guard let self = self else { return }
            CartManager.shared.updateQuantity(for: item.product, to: newQty)
            self.updateCheckoutButtonTitle()
            NotificationCenter.default.post(name: .cartUpdated, object: nil)
        }
        
        cell.onPlusTapped = { [weak self] newQty in
            guard let self = self else { return }
            CartManager.shared.updateQuantity(for: item.product, to: newQty)
            self.updateCheckoutButtonTitle()
            NotificationCenter.default.post(name: .cartUpdated, object: nil)
        }
        
        cell.onRemoveTapped = { [weak self] in
            guard let self = self else { return }
            CartManager.shared.removeProduct(item.product)
            tv.deleteRows(at: [indexPath], with: .fade)
            self.updateCheckoutButtonTitle()
            self.updateEmptyState()
            NotificationCenter.default.post(name: .cartUpdated, object: nil)
        }
        
        return cell
    }
    
    func tableView(_ tv: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return max(160, tv.frame.height / 6)
    }
}

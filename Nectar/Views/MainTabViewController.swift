//
//  MainTabViewController.swift
//  Nectar
//
//  Created by Mayank Jangid on 5/3/25.
//

import UIKit

// this file cz i wasnt able to update badge globally unitll i click on this so..... maybe there was a way without this but i am tired rn
class MainTabBarController: UITabBarController {

    private let cartTabIndex = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Observe cart changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateCartBadge),
            name: .cartUpdated,
            object: nil
        )
        // Initial badge
        updateCartBadge()
    }

    @objc private func updateCartBadge() {
        let totalCount = CartManager.shared.cartItems.reduce(0) { $0 + $1.quantity }
        guard let items = tabBar.items, items.count > cartTabIndex else { return }

        let cartItem = items[cartTabIndex]
        cartItem.badgeValue = totalCount > 0 ? "\(totalCount)" : nil
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

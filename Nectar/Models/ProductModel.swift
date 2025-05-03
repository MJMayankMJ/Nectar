//
//  ProductModel.swift
//  Nectar
//
//  Created by Mayank Jangid on 4/11/25.
//

import Foundation


// MARK: - Example Model and JSON Decoding

struct Product: Codable {
    let id: String
    let name: String
    let productDescription: String
    let price: Double
    let imageName: String
    let quantity: String
    let category: String
}

struct CartItem {
    let product: Product
    var quantity: Int
}

struct FavoriteItem {
    let product: Product
}

// MARK: - Managers

//class CartManager {
//    static let shared = CartManager()
//    var cartItems: [CartItem] = []
//    
//    private init() {}
//    
//    func addProduct(_ product: Product, quantity: Int) {
//        // Simple approach: add new item regardless of duplicates.
//        let newItem = CartItem(product: product, quantity: quantity)
//        cartItems.append(newItem)
//    }
//}

//MARK: - to update cart badge
extension Notification.Name {
    static let cartUpdated = Notification.Name("cartUpdated")
}

class CartManager {
    static let shared = CartManager()
    private init() {}
    
   var cartItems: [CartItem] = [] {
        didSet {
            NotificationCenter.default.post(name: .cartUpdated, object: nil)
        }
    }
    
    func addProduct(_ product: Product, quantity: Int) {
        if let idx = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[idx].quantity += quantity
        } else {
            cartItems.append(CartItem(product: product, quantity: quantity))
        }
    }
    
    func updateQuantity(for product: Product, to newQuantity: Int) {
        guard let idx = cartItems.firstIndex(where: { $0.product.id == product.id }) else { return }
        cartItems[idx].quantity = newQuantity
    }
    
    func removeProduct(_ product: Product) {
        cartItems.removeAll { $0.product.id == product.id }
    }
    
    func clearCart() {
        cartItems.removeAll()
    }
}



class FavoriteManager {
    static let shared = FavoriteManager()
    var favoriteItems: [FavoriteItem] = []
    
    private init() {}
    
    func addFavorite(_ product: Product) {
        // Check if already exists; if not, add
        if !favoriteItems.contains(where: { $0.product.id == product.id }) {
            favoriteItems.append(FavoriteItem(product: product))
        }
    }
    
    func removeFavorite(_ product: Product) {
        favoriteItems.removeAll { $0.product.id == product.id }
    }
    
    func isFavorite(_ product: Product) -> Bool {
        return favoriteItems.contains(where: { $0.product.id == product.id })
    }
}

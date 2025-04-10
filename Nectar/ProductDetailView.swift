//
//  ProductDetailView.swift
//  Nectar
//
//  Created by Mayank Jangid on 4/10/25.
//

import UIKit

class ProductDetailView: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var addToBasketButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    var product: Product?   // Product passed from HomeViewController
    private var currentQuantity: Int = 1
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // Configure the UI elements with product data
    private func configureUI() {
        guard let product = product else { return }
        
        productNameLabel.text = product.name
        productPriceLabel.text = String(format: "$%.2f", product.price)
        productDescriptionLabel.text = product.productDescription
        
        // Load image from asset catalog (using product.imageName; you can change this if needed)
        productImageView.image = UIImage(named: product.imageName)
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        
        // Setup Quantity Label and Buttons
        currentQuantity = 1
        quantityLabel.text = "\(currentQuantity)"
        
        // Set up favorite button initial state based on whether the product is already a favorite.
        updateFavoriteButtonUI()
    }
    
    private func updateFavoriteButtonUI() {
        guard let product = product else { return }
        let imageName = FavoriteManager.shared.isFavorite(product) ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        favoriteButton.tintColor = .systemRed
    }
    
    // MARK: - IBActions
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        if currentQuantity > 1 {
            currentQuantity -= 1
            quantityLabel.text = "\(currentQuantity)"
        }
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        currentQuantity += 1
        quantityLabel.text = "\(currentQuantity)"
    }
    
    @IBAction func addToBasketTapped(_ sender: UIButton) {
        guard let product = product else { return }
        CartManager.shared.addProduct(product, quantity: currentQuantity)
        print("Added \(product.name) to cart with quantity \(currentQuantity). Current cart count: \(CartManager.shared.cartItems.count)")
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        guard let product = product else { return }
        if FavoriteManager.shared.isFavorite(product) {
            FavoriteManager.shared.removeFavorite(product)
        } else {
            FavoriteManager.shared.addFavorite(product)
        }
        // Update the favorite button appearance
        updateFavoriteButtonUI()
        print("Favorites count: \(FavoriteManager.shared.favoriteItems.count)")
    }
    
    
}

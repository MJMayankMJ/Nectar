//
//  ProductDetailView.swift
//  Nectar
//
//  Created by Mayank Jangid on 4/10/25.
//

import UIKit

import UIKit

class ProductDetailView: UIViewController {
    
    // MARK: - IBOutlets (Connect these from your storyboard)
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel! // this is litre ,kg ,etc
    
    @IBOutlet weak var quantityLabel: UILabel! //this is 1,2,3
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var addToBasketButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    var product: Product?   // This will be passed from HomeViewController
    private var currentQuantity: Int = 1
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // Setup UI with product data
    private func configureUI() {
        guard let product = product else { return }
        
        productNameLabel.text = product.name
        productPriceLabel.text = String(format: "$%.2f", product.price)
        productDescriptionLabel.text = product.productDescription
        unitLabel.text = product.quantity
        
        // Load product image from assets using product.imageName
        productImageView.image = UIImage(named: product.imageName)
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        
        // Initialize quantity to 1
        currentQuantity = 1
        quantityLabel.text = "\(currentQuantity)"
        
        // Set favorite button's initial appearance based on favorite status
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
        // Add product to cart with current quantity using CartManager
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
        updateFavoriteButtonUI()
        print("Favorites count: \(FavoriteManager.shared.favoriteItems.count)")
    }
}

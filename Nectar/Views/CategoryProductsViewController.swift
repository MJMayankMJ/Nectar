//
//  CategoryProductsViewController.swift
//  Nectar
//
//  Created by Mayank Jangid on 4/15/25.
//

import UIKit

class CategoryProductsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //  category passed from ExploreViewController
    var selectedCategory: String?
    private var products: [Product] = []
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedCategory?.capitalized
        
        let nib = UINib(nibName: "ProductCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ProductCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        loadProducts()
    }
    
    // MARK: - Data Loading
    private func loadProducts() {
        guard let data = groceryProductsJSON.data(using: .utf8) else { return }
        do {
            let productsDict = try JSONDecoder().decode([String: Product].self, from: data)
            let allProducts = Array(productsDict.values)
            if let category = selectedCategory {
                // Filter products matching the category (case insensitive)
                products = allProducts.filter { $0.category.lowercased() == category.lowercased() }
            }
            collectionView.reloadData()
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}

// MARK: - UICollectionView DataSource, Delegate, & FlowLayout
extension CategoryProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        let product = products[indexPath.item]
        cell.configure(with: product)
        cell.onAddTapped = {
            CartManager.shared.addProduct(product, quantity: 1)
            print("Added \(product.name) to cart. Current cart count: \(CartManager.shared.cartItems.count)")
        }
        return cell
    }
    // need to fix the sizing will do it later
    // Sizing for cells
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 180)
    }
    
    // Section insets to add padding on the left and right
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    // Line spacing between cells
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

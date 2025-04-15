//
//  ViewController.swift
//  Nectar
//
//  Created by Mayank Jangid on 4/1/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var exclusiveCollectionView: UICollectionView!
    @IBOutlet weak var bestSellingCollectionView: UICollectionView!
    @IBOutlet weak var groceriesCollectionView: UICollectionView!
    
    // MARK: - Data Arrays
    private var allProducts: [Product] = []
    private var exclusiveProducts: [Product] = []
    private var bestSellingProducts: [Product] = []
    private var groceriesProducts: [Product] = []
    
    // Temporary cart/favorites (for demonstration)
    var cart: [Product] = []
    var favorites: [Product] = []
    private var bannerImages: [String] = ["banner1", "banner1", "banner1"]

    // temporarily store the product that is tapped.
    private var selectedProduct: Product?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        
        // Register the custom cell (ProductCell.xib)
        let nib = UINib(nibName: "ProductCell", bundle: nil)
        exclusiveCollectionView.register(nib, forCellWithReuseIdentifier: "ProductCell")
        bestSellingCollectionView.register(nib, forCellWithReuseIdentifier: "ProductCell")
        groceriesCollectionView.register(nib, forCellWithReuseIdentifier: "ProductCell")
        
        // Set delegates and data sources
        exclusiveCollectionView.delegate = self
        exclusiveCollectionView.dataSource = self
        bestSellingCollectionView.delegate = self
        bestSellingCollectionView.dataSource = self
        groceriesCollectionView.delegate = self
        groceriesCollectionView.dataSource = self
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        // Configure layout for horizontal scrolling
        if let flowLayout = exclusiveCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        if let flowLayout = bestSellingCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        if let flowLayout = groceriesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        
        loadProducts()
    }
    
    // MARK: - Data Loading
    private func loadProducts() {
        // Decode JSON string into allProducts array
        guard let data = groceryProductsJSON.data(using: .utf8) else { return }
        do {
            let productsDict = try JSONDecoder().decode([String: Product].self, from: data)
            allProducts = Array(productsDict.values)
            
            // For demo purposes, split products into 3 sections.
            exclusiveProducts = allProducts.filter { $0.category == "meat" }
            bestSellingProducts = allProducts.filter { $0.category == "beverages" }
            groceriesProducts = allProducts.filter { $0.category == "bakery" }
            
            // Reload the collection views
            exclusiveCollectionView.reloadData()
            bestSellingCollectionView.reloadData()
            groceriesCollectionView.reloadData()
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowProductDetail" {
            if let detailVC = segue.destination as? ProductDetailView,
               let product = sender as? Product {
                detailVC.product = product
            }
        }
    }
}

// MARK: - UICollectionView Data Source & Delegate
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Number of Items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCollectionView {
            return bannerImages.count
        } else if collectionView == exclusiveCollectionView {
            return exclusiveProducts.count
        } else if collectionView == bestSellingCollectionView {
            return bestSellingProducts.count
        } else if collectionView == groceriesCollectionView {
            return groceriesProducts.count
        }
        return 0
    }
    
    // MARK: - Cell Configuration
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollectionView {
            // Dequeue a banner cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath)
            // Assuming the banner cell's content view has an image view as its first subview:
            if let imageView = cell.contentView.subviews.first as? UIImageView {
                let imageName = bannerImages[indexPath.item]
                imageView.image = UIImage(named: imageName)
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
            }
            return cell
        }
        
        // For regular product cells, dequeue the ProductCell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        
        let product: Product
        if collectionView == exclusiveCollectionView {
            product = exclusiveProducts[indexPath.item]
        } else if collectionView == bestSellingCollectionView {
            product = bestSellingProducts[indexPath.item]
        } else {
            product = groceriesProducts[indexPath.item]
        }
        
        cell.configure(with: product)
        cell.onAddTapped = { [weak self] in
            guard let self = self else { return }
            self.cart.append(product)
            print("Added \(product.name) to cart. Current cart count: \(self.cart.count)")
        }
        return cell
    }
    
    // MARK: - Cell Sizing
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bannerCollectionView {
            return collectionView.bounds.size
        }
        return CGSize(width: 140, height: 180)
    }
    
    // MARK: - Spacing
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == bannerCollectionView {
            return 0
        }
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == bannerCollectionView {
            return 0
        }
        return 8
    }
    
    // MARK: - Cell Selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Skip tapping banner cells
        if collectionView == bannerCollectionView {
            print("Tapped banner at index \(indexPath.item)")
            return
        }
        
        let product: Product
        if collectionView == exclusiveCollectionView {
            product = exclusiveProducts[indexPath.item]
        } else if collectionView == bestSellingCollectionView {
            product = bestSellingProducts[indexPath.item]
        } else {
            product = groceriesProducts[indexPath.item]
        }
        print("Tapped on product: \(product.name)")
        // Save the selected product and perform the segue
        selectedProduct = product
        performSegue(withIdentifier: "ShowProductDetail", sender: product)
    }
    
    // for spacing on the left and right of collection view (after scroll)
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
            if collectionView == bannerCollectionView {
                return .zero
            } else {
                return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            }
        }
}


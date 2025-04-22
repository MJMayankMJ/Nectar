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
    
    // MARK: - Page Control & Timer -- i know i should do it with storyboard but that easy and i wanted to see if i can do it like this
    private lazy var bannerPageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.numberOfPages = bannerImages.count
        pc.currentPage = 0
        
        pc.pageIndicatorTintColor = .systemGray3
        pc.currentPageIndicatorTintColor = .white
        
        return pc
    }()
    private var bannerTimer: Timer?
    
    // MARK: - Data Arrays
    private var allProducts: [Product] = []
    private var exclusiveProducts: [Product] = []
    private var bestSellingProducts: [Product] = []
    private var groceriesProducts: [Product] = []
    
    // Temporary cart/favorites (for demonstration)
    var cart: [Product] = []
    var favorites: [Product] = []
    private var bannerImages: [String] = ["banner1", "banner1", "banner1"]

    private var selectedProduct: Product?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCarrotTitleView()
        setupCollectionViews()
        setupBannerPageControl()
        startBannerAutoScroll()
        loadProducts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        bannerTimer?.invalidate()
        bannerTimer = nil
    }
    
    // MARK: - Setup Methods
    private func setupCollectionViews() {
        // Register cells
        let nib = UINib(nibName: "ProductCell", bundle: nil)
        [exclusiveCollectionView, bestSellingCollectionView, groceriesCollectionView].forEach {
            $0?.register(nib, forCellWithReuseIdentifier: "ProductCell")
            $0?.delegate = self
            $0?.dataSource = self
            if let layout = $0?.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
            }
        }
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.layer.cornerRadius = 12
        bannerCollectionView.layer.masksToBounds = true
    }
    
    private func setupBannerPageControl() {
        view.addSubview(bannerPageControl)
        NSLayoutConstraint.activate([
            bannerPageControl.centerXAnchor.constraint(equalTo: bannerCollectionView.centerXAnchor),
            bannerPageControl.bottomAnchor.constraint(equalTo: bannerCollectionView.bottomAnchor, constant: -8)
        ])

        bannerCollectionView.bringSubviewToFront(bannerPageControl)
    }

    private func startBannerAutoScroll() {
        bannerTimer = Timer.scheduledTimer(
            timeInterval: 10,
            target: self,
            selector: #selector(autoScrollBanner),
            userInfo: nil,
            repeats: true
        )
    }
    
    // MARK: - Carrot Title
    private func setupCarrotTitleView() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        guard let img = UIImage(named: "Logo")?.withRenderingMode(.alwaysOriginal) else {
            print("Error : 'carrot' asset not found")
            return
        }
        let iv = UIImageView(image: img)
        iv.contentMode = .scaleAspectFit
        iv.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        navigationItem.titleView = iv
    }

    // MARK: - Data Loading
    private func loadProducts() {
        guard let data = groceryProductsJSON.data(using: .utf8) else { return }
        do {
            let productsDict = try JSONDecoder().decode([String: Product].self, from: data)
            allProducts = Array(productsDict.values)
            exclusiveProducts = allProducts.filter { $0.category == "meat" }
            bestSellingProducts = allProducts.filter { $0.category == "beverages" }
            groceriesProducts = allProducts.filter { $0.category == "bakery" }
            [exclusiveCollectionView, bestSellingCollectionView, groceriesCollectionView].forEach { $0?.reloadData() }
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowProductDetail",
           let detailVC = segue.destination as? ProductDetailView,
           let product = sender as? Product {
            detailVC.product = product
        }
    }
    
    // MARK: - Auto Scroll Selector
    @objc private func autoScrollBanner() {
        let next = (bannerPageControl.currentPage + 1) % bannerImages.count
        let idx = IndexPath(item: next, section: 0)
        bannerCollectionView.scrollToItem(at: idx, at: .centeredHorizontally, animated: true)
        bannerPageControl.currentPage = next
    }
}

// MARK: - UICollectionView Data Source & Delegate
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case bannerCollectionView: return bannerImages.count
        case exclusiveCollectionView: return exclusiveProducts.count
        case bestSellingCollectionView: return bestSellingProducts.count
        case groceriesCollectionView: return groceriesProducts.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath)
            if let imageView = cell.contentView.subviews.compactMap({ $0 as? UIImageView }).first {
                imageView.image = UIImage(named: bannerImages[indexPath.item])
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
            }
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        let product: Product = {
            switch collectionView {
            case exclusiveCollectionView: return exclusiveProducts[indexPath.item]
            case bestSellingCollectionView: return bestSellingProducts[indexPath.item]
            default: return groceriesProducts[indexPath.item]
            }
        }()
        cell.configure(with: product)
        cell.onAddTapped = { [weak self] in
            guard let self = self else { return }
            self.cart.append(product)
            print("Added \(product.name) to cart. Current cart count: \(self.cart.count)")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView == bannerCollectionView
            ? collectionView.bounds.size
            : CGSize(width: 140, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == bannerCollectionView ? 0 : 16
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == bannerCollectionView ? 0 : 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == bannerCollectionView {
            print("Tapped banner at index \(indexPath.item)")
            return
        }
        let product: Product = {
            switch collectionView {
            case exclusiveCollectionView: return exclusiveProducts[indexPath.item]
            case bestSellingCollectionView: return bestSellingProducts[indexPath.item]
            default: return groceriesProducts[indexPath.item]
            }
        }()
        selectedProduct = product
        performSegue(withIdentifier: "ShowProductDetail", sender: product)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == bannerCollectionView else { return }
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        bannerPageControl.currentPage = page
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return collectionView == bannerCollectionView
            ? .zero
            : UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

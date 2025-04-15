//
//  ExploreViewController.swift
//  Nectar
//
//  Created by Mayank Jangid on 4/15/25.
//

import UIKit

class ExploreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let exploreAssets = [
        "bakery",
        "beverages",
        "dairyEggs",
        "fruitsVegs",
        "meatFish",
        "oils"
    ]
    
    private let exploreTitles = [
        "Bakery",
        "Beverages",
        "Dairy & Eggs",
        "Fruits & Veggies",
        "Meat & Fish",
        "Cooking Oil & Ghee"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumInteritemSpacing = 8
            flowLayout.minimumLineSpacing = 8
            flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            // Disable automatic cell sizing by setting estimatedItemSize to .zero.
            flowLayout.estimatedItemSize = .zero
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
        // Print the collectionView bounds to see its current frame
        print("CollectionView Bounds: \(collectionView.bounds)")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exploreAssets.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCell", for: indexPath) as? ExploreCell else {
            return UICollectionViewCell()
        }
        
        let assetName = exploreAssets[indexPath.item]
        let title = exploreTitles[indexPath.item]
        let image = UIImage(named: assetName) ?? UIImage()
        
        cell.configure(with: image, title: title, assetName: assetName)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize.zero
        }
        
        let insets = flowLayout.sectionInset
        let interItemSpacing = flowLayout.minimumInteritemSpacing
        
        let totalHorizontalSpacing = insets.left + insets.right + interItemSpacing
        let cellWidth = (collectionView.bounds.width - totalHorizontalSpacing) / 2
        
        let lineSpacing = flowLayout.minimumLineSpacing
        let totalVerticalSpacing = insets.top + insets.bottom + (lineSpacing * 2)
        let cellHeight = (collectionView.bounds.height - totalVerticalSpacing) / 3
        
        print("Cell Size (Index \(indexPath.item)): \(cellWidth) x \(cellHeight)")
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let assetName = exploreAssets[indexPath.item]
            
            // Mapping between explore asset names and product categories in your JSON
            let categoryMapping: [String: String] = [
                "bakery": "bakery",
                "beverages": "beverages",
                "dairyEggs": "dairy eggs",
                "fruitsVegs": "fruit and veg",
                "meatFish": "meat",
                "oils": "oils"
            ]
            
            if let category = categoryMapping[assetName] {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let vc = storyboard.instantiateViewController(withIdentifier: "CategoryProductsViewController") as? CategoryProductsViewController {
                    vc.selectedCategory = category
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
}

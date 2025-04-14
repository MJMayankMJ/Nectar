//
//  ProductCell.swift
//  Nectar
//
//  Created by Mayank Jangid on 4/5/25.
//

import UIKit
import Kingfisher

class ProductCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    // Closure for handling add button tap
    var onAddTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Cell styling
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    
    // MARK: - Configuration
    func configure(with product: Product) {
        nameLabel.text = product.name
        priceLabel.text = String(format: "$%.2f", product.price)
        quantityLabel.text = product.quantity

        let placeholder = UIImage(named: "bakery")
        
        if let urlString = imageURLs[product.imageName],
           let url = URL(string: urlString) {
            // Use Kingfisher to load the image, and print debug info on success/failure.
            productImageView.kf.setImage(with: url, placeholder: placeholder, options: nil) { result in
                switch result {
                case .success(let value):
                    print("Kingfisher Debug: Successfully loaded image from \(urlString). Source: \(value.source)")
                case .failure(let error):
                    print("Kingfisher Debug: Failed to load image for key \(product.imageName). Error: \(error.localizedDescription)")
                    // Optional: Set a fallback image
                    self.productImageView.image = placeholder
                }
            }
        } else {
            print("Kingfisher Debug: URL not found for image key: \(product.imageName). Using placeholder.")
            productImageView.image = placeholder
        }
    }

    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: UIButton) {
        onAddTapped?()
    }
}

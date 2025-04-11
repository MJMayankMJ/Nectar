//
//  ProductCell.swift
//  Nectar
//
//  Created by Mayank Jangid on 4/5/25.
//

import UIKit
import Kingfisher

class ProductCell: UICollectionViewCell {
    
    // MARK: - Outlets (Connect these from your XIB)
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
    
    // Configure the cell with product data
    func configure(with product: Product) {
        nameLabel.text = product.name
        priceLabel.text = String(format: "$%.2f", product.price)
        quantityLabel.text = product.quantity
        
        // Use your extension to load the image (tries assets first, then remote URL)
        //productImageView.setImage(urlString: product.imageName) -- this is for late
        
        productImageView.image = UIImage(named: "oils")
    }
    
    // Action for the add button
    @IBAction func addButtonTapped(_ sender: UIButton) {
        onAddTapped?()
        //add to cart here
    }
}

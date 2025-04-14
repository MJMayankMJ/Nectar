//
//  FavoriteCell.swift
//  Nectar
//
//  Created by Mayank Jangid on 4/11/25.
//

import UIKit

class FavoriteCell: UITableViewCell {

    // MARK: - IBOutlets (Connect in the storyboard prototype cell)
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!      // This shows the "quantity" (unit) from the Product, e.g. "liter"
    @IBOutlet weak var priceLabel: UILabel!
    //@IBOutlet weak var removeButton: UIButton!    // maybe will add in future
    
    //thinking if should add it or not
    //var onRemoveTapped: (() -> Void)?
    
    // Configure the cell with a FavoriteItem
    func configure(with fav: FavoriteItem) {
        let product = fav.product
        nameLabel.text = product.name
        priceLabel.text = String(format: "$%.2f", product.price)
        unitLabel.text = product.quantity        
        // Set the image (adjust as needed)
        productImageView.image = UIImage(named: product.imageName)
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
    }
    
    // MARK: - IBActions
//    @IBAction func removeButtonTapped(_ sender: UIButton) {
//        onRemoveTapped?()
//    }
}

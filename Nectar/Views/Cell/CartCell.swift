//
//  CartCell.swift
//  Nectar
//
//  Created by Mayank Jangid on 4/11/25.
//

import UIKit

class CartCell: UITableViewCell {

    // MARK: - IBOutlets (Connect them in the storyboard prototype cell)
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityValueLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    
    @IBOutlet weak var userQuantityLabel: UILabel!
    
    var currentUserQuantity: Int = 1 {
            didSet {
                userQuantityLabel.text = "\(currentUserQuantity)"
            }
        }
    
    // Closure callbacks for button actions
    var onMinusTapped: ((Int) -> Void)?
    var onPlusTapped: ((Int) -> Void)?

    var onRemoveTapped: (() -> Void)?
    
    // Configure cell with a CartItem
    func configure(with item: CartItem) {
            let product = item.product
            nameLabel.text = product.name
            priceLabel.text = String(format: "$%.2f", product.price)
            quantityValueLabel.text = "\(product.quantity)"
            currentUserQuantity = item.quantity
            
            let placeholder = UIImage(named: "bakery")
            
            if let urlString = imageURLs[product.imageName],
               let url = URL(string: urlString) {
                productImageView.kf.setImage(with: url, placeholder: placeholder)
            } else {
                productImageView.image = placeholder
            }
        }
    
    // MARK: - IBActions
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        if currentUserQuantity > 1 {
            currentUserQuantity -= 1
            onMinusTapped?(currentUserQuantity)
        }
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        currentUserQuantity += 1
        onPlusTapped?(currentUserQuantity)
    }
    
    @IBAction func removeButtonTapped(_ sender: UIButton) {
        onRemoveTapped?()
    }
}

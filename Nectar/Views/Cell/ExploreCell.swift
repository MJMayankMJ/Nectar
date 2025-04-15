//
//  ExploreCell.swift
//  Nectar
//
//  Created by Mayank Jangid on 4/15/25.
//

import UIKit

class ExploreCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var bottomContainer: UIView!
    
    func configure(with image: UIImage, title: String, assetName: String) {
        cellImageView.image = image
        titleLabel.text = title
        configureColor(for: assetName)
    }
    
    private func configureColor(for assetName: String) {
        var backgroundColor: UIColor = .clear
        var borderColor: UIColor = .clear
        
        switch assetName {
        case "bakery":
            backgroundColor = .bakery
            topContainer.backgroundColor = .bakery
            bottomContainer.backgroundColor = .bakery
            borderColor = .bakeryOutline
        case "beverages":
            backgroundColor = .beverage
            topContainer.backgroundColor = .beverage
            bottomContainer.backgroundColor = .beverage
            borderColor = .beverageOutline
        case "dairyEggs":
            backgroundColor = .dairyEggs
            topContainer.backgroundColor = .dairyEggs
            bottomContainer.backgroundColor = .dairyEggs
            borderColor = .dairyEggsOutline
        case "fruitsVegs":
            backgroundColor = .fruitVeg
            topContainer.backgroundColor = .fruitVeg
            bottomContainer.backgroundColor = .fruitVeg
            borderColor = .fruitVegOutline
        case "meatFish":
            backgroundColor = .meatFish
            topContainer.backgroundColor = .meatFish
            bottomContainer.backgroundColor = .meatFish
            borderColor = .meatFishOutline
        case "oils":
            backgroundColor = .oils
            topContainer.backgroundColor = .oils
            bottomContainer.backgroundColor = .oils
            borderColor = .oilsOutline
        default:
            break
        }
        
        contentView.backgroundColor = backgroundColor
        layer.borderWidth = 1.0
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
}

//
//  ViewController.swift
//  Nectar
//
//  Created by Mayank Jangid on 4/1/25.
//
//
//import UIKit
// // was just trying some things without storyboard
//extension UIView {
//    func pinToEdges(of view: UIView, with constant: CGFloat = 0) {
//        NSLayoutConstraint.activate([
//            self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
//            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant),
//            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant),
//            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
//        ])
//    }
//    
//    func addSubViews(_ views: UIView...) {
//        views.forEach { self.addSubview($0) }
//    }
//}
import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = (newValue > 0)
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: cgColor)
        }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
}

extension UIStackView{
    
    @IBInspectable var shadowColor: UIColor {
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
}


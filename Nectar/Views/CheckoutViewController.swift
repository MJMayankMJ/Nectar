//
//  CheckoutViewController.swift
//  Nectar
//
//  Created by Mayank Jangid on 4/16/25.
//

import UIKit

//Note : Just for trying and learning i di this part progrmatically might not be perfect.... rest assure the rest of the app is using storyboard
class CheckoutBottomSheetViewController: UIViewController {

    // MARK: - Subviews
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Checkout"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("✕", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    // MARK: - Form Fields
    private let nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Full Name"
        tf.borderStyle = .roundedRect
        return tf
    }()

    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Email Address"
        tf.keyboardType = .emailAddress
        tf.borderStyle = .roundedRect
        return tf
    }()

    private let addressTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Shipping Address"
        tf.borderStyle = .roundedRect
        return tf
    }()

    // MARK: - Delivery Row Subviews
    private let deliveryTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Delivery:"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    private let deliveryValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "COD"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .right
        return label
    }()

    // MARK: - Total Amount Row Subviews
    private let totalAmountTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total amount:"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    private let totalAmountValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$0.00"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .right
        return label
    }()

    // Stack views
    private lazy var formStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameTextField, emailTextField, addressTextField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 12
        return stack
    }()

    private lazy var deliveryStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [deliveryTitleLabel, deliveryValueLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()

    private lazy var totalAmountStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [totalAmountTitleLabel, totalAmountValueLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()

    private let placeOrderButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Place Order", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setupSubviews()
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        placeOrderButton.addTarget(self, action: #selector(placeOrderTapped), for: .touchUpInside)
        updateTotalAmount()
    }

    private func setupSubviews() {
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(closeButton)
        containerView.addSubview(formStackView)
        containerView.addSubview(deliveryStackView)
        containerView.addSubview(totalAmountStackView)
        containerView.addSubview(placeOrderButton)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 400)
        ])

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16)
        ])

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalToConstant: 44)
        ])

        NSLayoutConstraint.activate([
            formStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            formStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            formStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            deliveryStackView.topAnchor.constraint(equalTo: formStackView.bottomAnchor, constant: 24),
            deliveryStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            deliveryStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            deliveryStackView.heightAnchor.constraint(equalToConstant: 24)
        ])

        NSLayoutConstraint.activate([
            totalAmountStackView.topAnchor.constraint(equalTo: deliveryStackView.bottomAnchor, constant: 16),
            totalAmountStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            totalAmountStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            totalAmountStackView.heightAnchor.constraint(equalToConstant: 24)
        ])

        NSLayoutConstraint.activate([
            placeOrderButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
            placeOrderButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            placeOrderButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            placeOrderButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        containerView.transform = CGAffineTransform(translationX: 0, y: containerView.frame.height)
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = .identity
        }
    }

    @objc private func closeTapped() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func placeOrderTapped() {
        guard let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let address = addressTextField.text, !address.isEmpty else {
            // Show an alert for missing fields
            let alert = UIAlertController(title: "Missing Info", message: "Please fill in all fields.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
            return
        }
        print("Name: \(name), Email: \(email), Address: \(address)")
        CartManager.shared.cartItems.removeAll()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let orderAcceptedVC = storyboard.instantiateViewController(withIdentifier: "OrderAcceptedViewController") as? OrderAcceptedViewController {
            orderAcceptedVC.modalPresentationStyle = .fullScreen
            present(orderAcceptedVC, animated: true, completion: nil)
        }
    }

    private func updateTotalAmount() {
        let total = CartManager.shared.cartItems.reduce(0.0) { result, item in
            result + (item.product.price * Double(item.quantity))
        }
        totalAmountValueLabel.text = String(format: "$%.2f", total)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, touch.view == self.view {
            dismiss(animated: true, completion: nil)
        }
    }
}

//
//  OrderAcceptedViewController.swift
//  Nectar
//
//  Created by Mayank Jangid on 4/16/25.
//

import UIKit

class OrderAcceptedViewController: UIViewController {
    
    @IBOutlet weak var checkmarkImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var msgDes: UILabel!
    @IBOutlet weak var goToExplore: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkmarkImageView.alpha = 0
        messageLabel.alpha = 0
        msgDes.alpha = 0
        goToExplore.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.checkmarkImageView.alpha = 1
            self.messageLabel.alpha = 1
            self.msgDes.alpha = 1
            self.goToExplore.alpha = 1
        })
    }
    
    // MARK: - IBActions
//    @IBAction func goToExploreTapped(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let exploreVC = storyboard.instantiateViewController(withIdentifier: "ExploreViewController") as? ExploreViewController {
//            // Check if there's a navigation controller; if not, present modally.
//            if let navController = self.navigationController {
//                navController.pushViewController(exploreVC, animated: true)
//            } else {
//                exploreVC.modalPresentationStyle = .fullScreen
//                present(exploreVC, animated: true, completion: nil)
//            }
//        }
//    }
    @IBAction func goToExploreTapped(_ sender: UIButton) {
      dismissAllModals {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first,
              let tabBar = window.rootViewController as? UITabBarController else {
          return
        }
        UIView.transition(with: tabBar.view,
                          duration: 0.4,
                          options: .transitionFlipFromLeft,
                          animations: {
                            tabBar.selectedIndex = 0
                          },
                          completion: nil)
      }
    }

    
    func dismissAllModals(completion: @escaping ()->Void) {
      guard let root = UIApplication.shared.connectedScenes
              .compactMap({ $0 as? UIWindowScene })
              .first?.windows.first?.rootViewController else {
        completion(); return
      }
      // dismiss any presented VCs
      root.dismiss(animated: false, completion: completion)
    }

    

}

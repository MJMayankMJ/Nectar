//
//  ViewController.swift
//  Nectar
//
//  Created by Mayank Jangid on 4/1/25.
//

import UIKit


let imageURLs: [String: String] = [
    "apple_cider": "https://i.postimg.cc/TP9C8sGh/temp-Image-Ppark1.avif",
    "beef_steak": "https://i.postimg.cc/pTLkPBXC/temp-Image-Qrpn8-X.avif",
    "chicken_breast": "https://i.postimg.cc/qqtL3MKC/temp-Image6f-Z1z2.avif",
    "coffee": "https://i.postimg.cc/prgBYbQc/temp-Imagel7v-Akh.avif",
    "fish_fillet": "https://i.postimg.cc/Z56wHRM8/temp-Image-Gk-XF5b.avif",
    "green_tea": "https://i.postimg.cc/YCNxgPv8/temp-Imagei-Js00-M.avif",
    "iced_tea": "https://i.postimg.cc/tgXNzzPb/temp-Imagek-L0u-I8.avif",
    "lamb_rack": "https://i.postimg.cc/JnYx0BsL/temp-Image-O0-Ly-Np.avif",
    "orange_juice": "https://i.postimg.cc/T2SQXg8j/temp-Image-B9sp9j.avif",
    "pork_chops": "https://i.postimg.cc/Kv69tLJc/temp-Image-Kf47-Kq.avif",
    "sparkling_water": "https://i.postimg.cc/XY68rWYp/temp-Imagelp-PJ6j.avif",
    "turkey_legs": "https://i.postimg.cc/3w7ncTsP/temp-Imagee-Q6k-YV.avif"
]


// was just trying some things without storyboard

struct Images {
    struct Welcome {
        static let logo = UIImage(named: "logo")!
        static let background = UIImage(named: "welcomeBackground")!
    }
    
    struct Category {
        static let bakery = UIImage(named: "bakery")!
        static let beverages = UIImage(named: "beverages")!
        static let dairyEggs = UIImage(named: "dairyEggs")!
        static let fruitsVegs = UIImage(named: "fruitsVegs")!
        static let meatFish = UIImage(named: "meatFish")!
        static let oils = UIImage(named: "oils")!
    }
}

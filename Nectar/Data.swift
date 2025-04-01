//
//  Data.swift
//  Nectar
//
//  Created by Mayank Jangid on 4/2/25.
//

import Foundation

let groceryProductsJSON = """
{
  "550e8400-e29b-41d4-a716-446655440001": {
    "id": "550e8400-e29b-41d4-a716-446655440001",
    "name": "Chicken Breast",
    "productDescription": "Fresh and lean chicken breast perfect for grilling, roasting, or stir-frying meals at home.",
    "price": 7.99,
    "imageName": "chicken_breast",
    "quantity": "kg",
    "category": "meat"
  },
  "550e8400-e29b-41d4-a716-446655440002": {
    "id": "550e8400-e29b-41d4-a716-446655440002",
    "name": "Beef Steak",
    "productDescription": "Premium beef steak with excellent marbling, ideal for a hearty dinner or special occasion.",
    "price": 14.99,
    "imageName": "beef_steak",
    "quantity": "kg",
    "category": "meat"
  },
  "550e8400-e29b-41d4-a716-446655440003": {
    "id": "550e8400-e29b-41d4-a716-446655440003",
    "name": "Pork Chops",
    "productDescription": "Juicy pork chops that are tender and flavorful, great for quick and easy weeknight dinners.",
    "price": 9.49,
    "imageName": "pork_chops",
    "quantity": "kg",
    "category": "meat"
  },
  "550e8400-e29b-41d4-a716-446655440004": {
    "id": "550e8400-e29b-41d4-a716-446655440004",
    "name": "Lamb Rack",
    "productDescription": "Delicious lamb rack with a rich, savory taste, perfect for roasting and family meals.",
    "price": 19.99,
    "imageName": "lamb_rack",
    "quantity": "kg",
    "category": "meat"
  },
  "550e8400-e29b-41d4-a716-446655440005": {
    "id": "550e8400-e29b-41d4-a716-446655440005",
    "name": "Turkey Legs",
    "productDescription": "Succulent turkey legs that are slowly roasted for a tender and juicy flavor profile.",
    "price": 8.99,
    "imageName": "turkey_legs",
    "quantity": "kg",
    "category": "meat"
  },
  "550e8400-e29b-41d4-a716-446655440006": {
    "id": "550e8400-e29b-41d4-a716-446655440006",
    "name": "Fish Fillet",
    "productDescription": "Mild and flaky fish fillet ideal for pan-frying or baking with a light seasoning.",
    "price": 11.99,
    "imageName": "fish_fillet",
    "quantity": "kg",
    "category": "meat"
  },
  "550e8400-e29b-41d4-a716-446655440007": {
    "id": "550e8400-e29b-41d4-a716-446655440007",
    "name": "Orange Juice",
    "productDescription": "Freshly squeezed orange juice with a tangy and refreshing taste to start your day.",
    "price": 3.49,
    "imageName": "orange_juice",
    "quantity": "liter",
    "category": "beverages"
  },
  "550e8400-e29b-41d4-a716-446655440008": {
    "id": "550e8400-e29b-41d4-a716-446655440008",
    "name": "Apple Cider",
    "productDescription": "Crisp apple cider with a natural sweetness that pairs well with a variety of meals.",
    "price": 4.29,
    "imageName": "apple_cider",
    "quantity": "liter",
    "category": "beverages"
  },
  "550e8400-e29b-41d4-a716-446655440009": {
    "id": "550e8400-e29b-41d4-a716-446655440009",
    "name": "Sparkling Water",
    "productDescription": "Refreshing sparkling water that is lightly carbonated, ideal for hydration any time.",
    "price": 1.99,
    "imageName": "sparkling_water",
    "quantity": "liter",
    "category": "beverages"
  },
  "550e8400-e29b-41d4-a716-446655440010": {
    "id": "550e8400-e29b-41d4-a716-446655440010",
    "name": "Iced Tea",
    "productDescription": "Cool and invigorating iced tea with a subtle blend of natural flavors and no added sugar.",
    "price": 2.49,
    "imageName": "iced_tea",
    "quantity": "liter",
    "category": "beverages"
  },
  "550e8400-e29b-41d4-a716-446655440011": {
    "id": "550e8400-e29b-41d4-a716-446655440011",
    "name": "Coffee",
    "productDescription": "Rich and aromatic ground coffee that delivers a robust flavor for your morning brew.",
    "price": 5.99,
    "imageName": "coffee",
    "quantity": "kg",
    "category": "beverages"
  },
  "550e8400-e29b-41d4-a716-446655440012": {
    "id": "550e8400-e29b-41d4-a716-446655440012",
    "name": "Green Tea",
    "productDescription": "Organic green tea leaves offering a delicate, refreshing flavor and natural antioxidants.",
    "price": 4.99,
    "imageName": "green_tea",
    "quantity": "kg",
    "category": "beverages"
  },
  "550e8400-e29b-41d4-a716-446655440013": {
    "id": "550e8400-e29b-41d4-a716-446655440013",
    "name": "Whole Wheat Bread",
    "productDescription": "Freshly baked whole wheat bread that is soft inside with a hearty, nutty crust.",
    "price": 2.99,
    "imageName": "whole_wheat_bread",
    "quantity": "pieces",
    "category": "bakery"
  },
  "550e8400-e29b-41d4-a716-446655440014": {
    "id": "550e8400-e29b-41d4-a716-446655440014",
    "name": "Croissant",
    "productDescription": "Flaky and buttery croissant with a golden exterior, perfect for a light breakfast.",
    "price": 1.49,
    "imageName": "croissant",
    "quantity": "pieces",
    "category": "bakery"
  },
  "550e8400-e29b-41d4-a716-446655440015": {
    "id": "550e8400-e29b-41d4-a716-446655440015",
    "name": "Bagel",
    "productDescription": "Chewy and dense bagel ideal for toasting and pairing with your favorite spreads.",
    "price": 0.99,
    "imageName": "bagel",
    "quantity": "pieces",
    "category": "bakery"
  },
  "550e8400-e29b-41d4-a716-446655440016": {
    "id": "550e8400-e29b-41d4-a716-446655440016",
    "name": "Muffin",
    "productDescription": "Soft and moist muffin available in a variety of flavors to brighten up your morning.",
    "price": 1.79,
    "imageName": "muffin",
    "quantity": "pieces",
    "category": "bakery"
  },
  "550e8400-e29b-41d4-a716-446655440017": {
    "id": "550e8400-e29b-41d4-a716-446655440017",
    "name": "Donut",
    "productDescription": "Sweet and soft donut with a light glaze finish, making it a delightful treat any time.",
    "price": 0.89,
    "imageName": "donut",
    "quantity": "pieces",
    "category": "bakery"
  },
  "550e8400-e29b-41d4-a716-446655440018": {
    "id": "550e8400-e29b-41d4-a716-446655440018",
    "name": "Baguette",
    "productDescription": "Crisp on the outside and soft on the inside, this traditional baguette is perfect for sandwiches.",
    "price": 1.99,
    "imageName": "baguette",
    "quantity": "pieces",
    "category": "bakery"
  },
  "550e8400-e29b-41d4-a716-446655440019": {
    "id": "550e8400-e29b-41d4-a716-446655440019",
    "name": "Fresh Apples",
    "productDescription": "Crisp and juicy apples with a natural sweetness, ideal for snacking and baking.",
    "price": 3.49,
    "imageName": "fresh_apples",
    "quantity": "kg",
    "category": "fruit and veg"
  },
  "550e8400-e29b-41d4-a716-446655440020": {
    "id": "550e8400-e29b-41d4-a716-446655440020",
    "name": "Bananas",
    "productDescription": "Ripe bananas with a creamy texture and rich flavor, perfect for smoothies or a quick snack.",
    "price": 2.29,
    "imageName": "bananas",
    "quantity": "kg",
    "category": "fruit and veg"
  },
  "550e8400-e29b-41d4-a716-446655440021": {
    "id": "550e8400-e29b-41d4-a716-446655440021",
    "name": "Carrots",
    "productDescription": "Crunchy and naturally sweet carrots, excellent for salads, stews, or as a healthy snack.",
    "price": 1.99,
    "imageName": "carrots",
    "quantity": "kg",
    "category": "fruit and veg"
  },
  "550e8400-e29b-41d4-a716-446655440022": {
    "id": "550e8400-e29b-41d4-a716-446655440022",
    "name": "Broccoli",
    "productDescription": "Fresh broccoli florets full of vitamins and minerals, ideal for steaming or stir-frying.",
    "price": 2.79,
    "imageName": "broccoli",
    "quantity": "kg",
    "category": "fruit and veg"
  },
  "550e8400-e29b-41d4-a716-446655440023": {
    "id": "550e8400-e29b-41d4-a716-446655440023",
    "name": "Spinach",
    "productDescription": "Tender spinach leaves packed with nutrients, great for salads, smoothies, or cooking.",
    "price": 2.49,
    "imageName": "spinach",
    "quantity": "kg",
    "category": "fruit and veg"
  },
  "550e8400-e29b-41d4-a716-446655440024": {
    "id": "550e8400-e29b-41d4-a716-446655440024",
    "name": "Tomatoes",
    "productDescription": "Vibrant and ripe tomatoes that add a burst of flavor to any salad or sauce.",
    "price": 2.99,
    "imageName": "tomatoes",
    "quantity": "kg",
    "category": "fruit and veg"
  },
  "550e8400-e29b-41d4-a716-446655440025": {
    "id": "550e8400-e29b-41d4-a716-446655440025",
    "name": "Organic Milk",
    "productDescription": "Fresh organic milk sourced from grass-fed cows, offering a rich and creamy taste.",
    "price": 3.99,
    "imageName": "organic_milk",
    "quantity": "liter",
    "category": "dairy eggs"
  },
  "550e8400-e29b-41d4-a716-446655440026": {
    "id": "550e8400-e29b-41d4-a716-446655440026",
    "name": "Cheddar Cheese",
    "productDescription": "Aged cheddar cheese with a sharp, tangy flavor perfect for sandwiches and snacks.",
    "price": 5.49,
    "imageName": "cheddar_cheese",
    "quantity": "kg",
    "category": "dairy eggs"
  },
  "550e8400-e29b-41d4-a716-446655440027": {
    "id": "550e8400-e29b-41d4-a716-446655440027",
    "name": "Greek Yogurt",
    "productDescription": "Creamy Greek yogurt rich in protein, ideal for breakfast, smoothies, or a healthy dessert.",
    "price": 4.49,
    "imageName": "greek_yogurt",
    "quantity": "kg",
    "category": "dairy eggs"
  },
  "550e8400-e29b-41d4-a716-446655440028": {
    "id": "550e8400-e29b-41d4-a716-446655440028",
    "name": "Eggs",
    "productDescription": "Farm-fresh eggs with a bright yolk and firm white, suitable for any meal or recipe.",
    "price": 2.99,
    "imageName": "eggs",
    "quantity": "pieces",
    "category": "dairy eggs"
  },
  "550e8400-e29b-41d4-a716-446655440029": {
    "id": "550e8400-e29b-41d4-a716-446655440029",
    "name": "Butter",
    "productDescription": "Rich and creamy butter made from fresh cream, perfect for baking and spreading on toast.",
    "price": 3.49,
    "imageName": "butter",
    "quantity": "kg",
    "category": "dairy eggs"
  },
  "550e8400-e29b-41d4-a716-446655440030": {
    "id": "550e8400-e29b-41d4-a716-446655440030",
    "name": "Cottage Cheese",
    "productDescription": "Soft and mild cottage cheese ideal for snacking, mixing with fruits, or as a salad topping.",
    "price": 4.19,
    "imageName": "cottage_cheese",
    "quantity": "kg",
    "category": "dairy eggs"
  },
  "550e8400-e29b-41d4-a716-446655440031": {
    "id": "550e8400-e29b-41d4-a716-446655440031",
    "name": "Olive Oil",
    "productDescription": "Extra virgin olive oil with a robust, fruity flavor perfect for dressings and cooking.",
    "price": 6.99,
    "imageName": "olive_oil",
    "quantity": "liter",
    "category": "oils"
  },
  "550e8400-e29b-41d4-a716-446655440032": {
    "id": "550e8400-e29b-41d4-a716-446655440032",
    "name": "Sunflower Oil",
    "productDescription": "Light and versatile sunflower oil ideal for frying, baking, and salad dressings.",
    "price": 4.99,
    "imageName": "sunflower_oil",
    "quantity": "liter",
    "category": "oils"
  },
  "550e8400-e29b-41d4-a716-446655440033": {
    "id": "550e8400-e29b-41d4-a716-446655440033",
    "name": "Coconut Oil",
    "productDescription": "Pure coconut oil with a subtle tropical aroma, excellent for cooking and skin care.",
    "price": 7.49,
    "imageName": "coconut_oil",
    "quantity": "liter",
    "category": "oils"
  },
  "550e8400-e29b-41d4-a716-446655440034": {
    "id": "550e8400-e29b-41d4-a716-446655440034",
    "name": "Canola Oil",
    "productDescription": "Heart-healthy canola oil that is light in taste and perfect for everyday cooking.",
    "price": 5.49,
    "imageName": "canola_oil",
    "quantity": "liter",
    "category": "oils"
  },
  "550e8400-e29b-41d4-a716-446655440035": {
    "id": "550e8400-e29b-41d4-a716-446655440035",
    "name": "Sesame Oil",
    "productDescription": "Flavorful sesame oil that adds a nutty aroma and taste to stir-fries and dressings.",
    "price": 6.49,
    "imageName": "sesame_oil",
    "quantity": "liter",
    "category": "oils"
  },
  "550e8400-e29b-41d4-a716-446655440036": {
    "id": "550e8400-e29b-41d4-a716-446655440036",
    "name": "Peanut Oil",
    "productDescription": "Mild peanut oil that is great for deep-frying and cooking with a subtle, nutty flavor.",
    "price": 5.99,
    "imageName": "peanut_oil",
    "quantity": "liter",
    "category": "oils"
  }
}
"""

// MARK: - Example Model and JSON Decoding

struct Product: Codable {
    let id: String
    let name: String
    let productDescription: String
    let price: Double
    let imageName: String
    let quantity: String
    let category: String
}

// Example usage: Parsing the JSON string into a dictionary of Product objects.
//if let jsonData = groceryProductsJSON.data(using: .utf8) {
//    do {
//        let productsDict = try JSONDecoder().decode([String: Product].self, from: jsonData)
//        // Now you can use the productsDict in your app
//        print(productsDict)
//    } catch {
//        print("Error parsing JSON: \(error)")
//    }
//}

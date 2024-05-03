//
//  FoodDataStructs.swift
//  CalorieQuest
//
//  Created by Group 11: Vijay Vadi, Brighton Young, and Marlin Spears.
//  Copyright © 2024 Vijay, Brighton, and Marlin. All rights reserved.
//

import Foundation

struct DayStruct: Decodable, Encodable {
    
    var date: String
    var tracked = [TrackedStruct]()
}

struct TrackedStruct: Decodable, Encodable {
    
    var category: String
    var time: String
    var foods = [FoodStruct]()
}

struct FoodStruct: Decodable, Encodable {
    
    var name: String
    var itemId: String
    var imageUrl: String
    var servingSize: Double
    var servingUnit: String
    var nutrients = [NutrientStruct]()
}

struct NutrientStruct: Decodable, Encodable {
    
    var name: String
    var amount: Double
    var unit: String
}



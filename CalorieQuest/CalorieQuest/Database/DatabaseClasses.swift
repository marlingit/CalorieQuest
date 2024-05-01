//
//  DatabaseClasses.swift
//  CalorieQuest
//
//  Created by Marlin on 4/30/24.
//

import SwiftUI
import SwiftData

@Model
final class Day {
    
    var date: String
    
    @Relationship(deleteRule: .nullify) var tracked: [Tracked]?
    
    init(date: String, tracked: [Tracked]) {
        self.date = date
        self.tracked = tracked
    }
}

@Model
final class Tracked {
    
    var category: String
    var time: String
    
    @Relationship(deleteRule: .nullify) var foods: [Food]?
    
    init(category: String, time: String, foods: [Food]) {
        self.category = category
        self.time = time
        self.foods = foods
    }
}

@Model
final class Meal {
    
    @Attribute(.unique) var name: String
    
    @Relationship(deleteRule: .nullify) var foods: [Food]?
    
    init(name: String, foods: [Food]?) {
        self.name = name
        self.foods = foods
    }
}

@Model
final class Food {
    
    var name: String
    var imageFileName: String
    var servingSize: Double
    var servingUnit: String
    
    @Relationship(deleteRule: .nullify) var nutrients: [Nutrient]?
    
    init(name: String, imageFileName: String, servingSize: Double, servingUnit: String, nutrients: [Nutrient]?) {
        self.name = name
        self.imageFileName = imageFileName
        self.servingSize = servingSize
        self.servingUnit = servingUnit
        self.nutrients = nutrients
    }
}

@Model
final class Nutrient {
    
    var name: String
    var amount: Double
    var unit: String
    
    init(name: String, amount: Double, unit: String) {
        self.name = name
        self.amount = amount
        self.unit = unit
    }
}


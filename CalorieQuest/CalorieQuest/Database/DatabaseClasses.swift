//
//  DatabaseClasses.swift
//  CalorieQuest
//
//  Created by Group 11: Vijay Vadi, Brighton Young, and Marlin Spears.
//  Copyright © 2024 Vijay, Brighton, and Marlin. All rights reserved.
//

import SwiftUI
import SwiftData

@Model
final class Day {
    
    var date: String
    
    @Relationship(deleteRule: .nullify) var tracked: [Tracked]?
    
    init(date: String, tracked: [Tracked]? = nil) {
        self.date = date
        self.tracked = tracked
    }
}

@Model
final class Tracked {
    
    var category: String
    var time: String
    
    @Relationship(deleteRule: .nullify) var foods: [Food]?
    
    init(category: String, time: String, foods: [Food]? = nil) {
        self.category = category
        self.time = time
        self.foods = foods
    }
}

@Model
final class Food {
    var name: String
    var itemId: String
    var imageUrl: String
    var servingSize: Double
    var servingUnit: String
    var imageFilename: String?
    @Relationship(deleteRule: .nullify) var nutrients: [Nutrient]?
    
    init(name: String, itemId: String, imageUrl: String, servingSize: Double, servingUnit: String, imageFilename: String? = nil, nutrients: [Nutrient]? = nil) {
        self.name = name
        self.itemId = itemId
        self.imageUrl = imageUrl
        self.servingSize = servingSize
        self.servingUnit = servingUnit
        self.imageFilename = imageFilename
        self.nutrients = nutrients
    }
}

@Model
final class Nutrient {
    
    var name: String
    var amount: Double
    var unit: String
    
    @Relationship(deleteRule: .nullify) var foods: [Food]?
    
    init(name: String, amount: Double, unit: String, foods: [Food]? = nil) {
        self.name = name
        self.amount = amount
        self.unit = unit
        self.foods = foods
    }
}

@Model
final class Video {
    
    var id: Int
    var title: String
    var youtubeId: String
    var releaseDate: String
    var duration: String
    
    init(id: Int, title: String, youtubeId: String, releaseDate: String, duration: String) {
        self.id = id
        self.title = title
        self.youtubeId = youtubeId
        self.releaseDate = releaseDate
        self.duration = duration
    }
}

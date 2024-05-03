//
//  DatabaseSearch.swift
//  CalorieQuest
//
//  Created by Group 11: Vijay Vadi, Brighton Young, and Marlin Spears.
//  Copyright © 2024 Vijay, Brighton, and Marlin. All rights reserved.
//

import SwiftUI
import SwiftData

var databaseSearchResults = [Food]()
var searchQuery = ""

public func conductDatabaseSearch() {
    var modelContainer: ModelContainer
    do {
        modelContainer = try ModelContainer(for: Day.self, Tracked.self, Food.self, Nutrient.self, Video.self)
    } catch {
        fatalError("Unable to create ModelContainer")
    }
    
    let modelContext = ModelContext(modelContainer)
    databaseSearchResults = [Food]()
    
    print("Search Query: \(searchQuery)") // Print the search query
    
    var foodPredicate = #Predicate<Food> {
        $0.name.localizedStandardContains(searchQuery) // Use case-insensitive search
    }
    
    let fetchDescriptor = FetchDescriptor<Food>(
        predicate: foodPredicate,
        sortBy: [SortDescriptor(\Food.name, order: .forward)]
    )
    
    do {
        databaseSearchResults = try modelContext.fetch(fetchDescriptor)
        print("Search Results Count: \(databaseSearchResults.count)") // Print the search results count
    } catch {
        fatalError("Unable to fetch data from the database")
    }
}

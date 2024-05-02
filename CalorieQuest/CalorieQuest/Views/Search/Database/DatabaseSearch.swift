//
//  DatabaseSearch.swift
//  CalorieQuest
//
//  Created by Marlin on 5/1/24.
//  Copyright © 2024 Marlin Spears. All rights reserved.
//

import SwiftUI
import SwiftData

// Global variable to hold database search results
var databaseSearchResults = [Food]()

var searchQuery = ""
var searchCategory = ""

public func conductDatabaseSearch() {
    
    /*
     ------------------------------------------------
     |   Create Model Container and Model Context   |
     ------------------------------------------------
     */
    var modelContainer: ModelContainer

    do {
        // Create a database container to manage database objects
        modelContainer = try ModelContainer(for: Day.self, Tracked.self, Food.self, Nutrient.self, Video.self)
    } catch {
        fatalError("Unable to create ModelContainer")
    }
    
    // Create the context (workspace) where database objects will be managed
    let modelContext = ModelContext(modelContainer)
    
    // Initialize the global variable to hold the database search results
    databaseSearchResults = [Food]()
    
    var foodPredicate = #Predicate<Food> {
        $0.name.localizedStandardContains(searchQuery)
    }
    
    let fetchDescriptor = FetchDescriptor<Food>(
        predicate: foodPredicate,
        sortBy: [SortDescriptor(\Food.name, order: .forward)]
    )
    
    do {
        databaseSearchResults = try modelContext.fetch(fetchDescriptor)
    } catch {
        fatalError("Unable to fetch data from the database")
    }
}

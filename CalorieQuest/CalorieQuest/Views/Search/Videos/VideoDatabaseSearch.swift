//
//  VideoDatabaseSearch.swift
//  CalorieQuest
//
//  Created by Group 11: Vijay Vadi, Brighton Young, and Marlin Spears.
//  Copyright © 2024 Vijay, Brighton, and Marlin. All rights reserved.
//

import SwiftUI
import SwiftData

var videoSearchResults = [Video]()
var videoSearchQuery = ""

public func conductVideoDatabaseSearch() {
    var modelContainer: ModelContainer
    
    do {
        modelContainer = try ModelContainer(for: Day.self, Tracked.self, Food.self, Nutrient.self, Video.self)
    } catch {
        fatalError("Unable to create ModelContainer")
    }
    
    let modelContext = ModelContext(modelContainer)
    videoSearchResults = [Video]()
    
    print("Search Query: \(videoSearchQuery)") // Print the search query
    
    var videoPredicate = #Predicate<Video> {
        $0.title.localizedStandardContains(videoSearchQuery) // Use case-insensitive search
    }
    
    let fetchDescriptor = FetchDescriptor<Video>(
        predicate: videoPredicate,
        sortBy: [SortDescriptor(\Video.title, order: .forward)]
    )
    
    do {
        videoSearchResults = try modelContext.fetch(fetchDescriptor)
        print("Search Results Count: \(videoSearchResults.count)") // Print the search results count
    } catch {
        fatalError("Unable to fetch data from the database")
    }
}

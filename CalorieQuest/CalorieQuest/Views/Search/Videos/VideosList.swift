//
//  VideosList.swift
//  CalorieQuest
//
//  Created by Group 11: Vijay Vadi, Brighton Young, and Marlin Spears.
//  Copyright © 2024 Vijay, Brighton, and Marlin. All rights reserved.
//

import SwiftUI
import SwiftData

struct VideosList: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(FetchDescriptor<Video>(sortBy: [SortDescriptor(\Video.title, order: .forward)])) private var listOfAllVideosInDatabase: [Video]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(listOfAllVideosInDatabase) { aVideo in
                    NavigationLink(destination: WebView(url: "https://www.youtube.com/watch?v=\(aVideo.youtubeId)")
                        .edgesIgnoringSafeArea(.all)) {
                            VideosItem(video: aVideo)
                        }
                }
            }
            .navigationTitle("Videos List")
        }
    }
}

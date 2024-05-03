//
//  VideoResultsList.swift
//  CalorieQuest
//
//  Created by Group 11: Vijay Vadi, Brighton Young, and Marlin Spears.
//  Copyright © 2024 Vijay, Brighton, and Marlin. All rights reserved.
//

import SwiftUI

struct VideoResultsList: View {
    
    let videoArray: [Video]
    var body: some View {
        NavigationStack {
            List {
                ForEach(videoArray) { aVideo in
                    NavigationLink(destination: WebView(url: "https://www.youtube.com/watch?v=\(aVideo.youtubeId)")
                        .edgesIgnoringSafeArea(.all)) {
                            VideosItem(video: aVideo)
                        }
                }
            }
            .navigationTitle("Video Search List")
        }
    }
}

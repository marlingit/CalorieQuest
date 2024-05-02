//
//  VideoResultsList.swift
//  CalorieQuest
//
//  Created by Brighton Young on 5/2/24.
//  Copyright © 2024 Marlin Spears. All rights reserved.
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

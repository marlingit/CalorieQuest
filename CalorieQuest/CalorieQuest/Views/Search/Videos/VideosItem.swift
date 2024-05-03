//
//  VideosItem.swift
//  CalorieQuest
//
//  Created by Group 11: Vijay Vadi, Brighton Young, and Marlin Spears.
//  Copyright © 2024 Vijay, Brighton, and Marlin. All rights reserved.
//

import SwiftUI

struct VideosItem: View {
    let video: Video
    var body: some View {
        
        HStack{
            getImageFromUrl(url: "https://img.youtube.com/vi/\(video.youtubeId)/mqdefault.jpg", defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 128.0)
                .frame(height: 72.0)
            VStack(alignment: .leading) {
                Text(video.title)
                Text(video.releaseDate)
                Text(video.duration)
            }//end VStack
            
            .font(.system(size: 16))
        }//end HStack
    }//end body
}


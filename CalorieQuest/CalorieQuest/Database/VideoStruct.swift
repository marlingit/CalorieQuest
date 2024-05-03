//
//  VideoStruct.swift
//  CalorieQuest
//
//  Created by Group 11: Vijay Vadi, Brighton Young, and Marlin Spears.
//  Copyright © 2024 Vijay, Brighton, and Marlin. All rights reserved.
//

import Foundation

struct VideoStruct: Decodable, Identifiable {
    
    var id: Int
    var title: String
    var youtubeId: String
    var releaseDate: String
    var duration: String
}

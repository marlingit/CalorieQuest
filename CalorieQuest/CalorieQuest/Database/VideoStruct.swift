//
//  VideoStruct.swift
//  CalorieQuest
//
//  Created by Marlin on 4/30/24.
//  Copyright © 2024 Marlin Spears. All rights reserved.
//

import Foundation

struct VideoStruct: Decodable, Identifiable {
    
    var id: Int
    var title: String
    var youtubeId: String
    var releaseDate: String
    var duration: String
}

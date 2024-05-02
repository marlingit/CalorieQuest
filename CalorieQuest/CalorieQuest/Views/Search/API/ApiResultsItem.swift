//
//  ApiResultsItem.swift
//  CalorieQuest
//
//  Created by Brighton Young on 5/2/24.
//  Copyright © 2024 Marlin Spears. All rights reserved.
//

import SwiftUI

struct ApiResultsItem: View {
    let food: FoodStruct
    var body: some View {
        HStack {
            getImageFromUrl(url: food.imageUrl, defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100.0, height: 75.0)
            
            VStack(alignment: .leading) {
                Text(food.name.components(separatedBy: " ")
                    .map { $0.capitalized }
                    .joined(separator: " "))
                Text(String(food.servingSize))
                Text(food.servingUnit.components(separatedBy: " ")
                    .map { $0.capitalized }
                    .joined(separator: " "))
            }
            .font(.system(size: 16))
        }
        
    }
}

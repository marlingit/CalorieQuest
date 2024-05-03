//
//  DatabaseResultsItem.swift
//  CalorieQuest
//
//  Created by Group 11: Vijay Vadi, Brighton Young, and Marlin Spears.
//  Copyright © 2024 Vijay, Brighton, and Marlin. All rights reserved.
//

import SwiftUI

struct DatabaseResultsItem: View {
    let food: Food
    var body: some View {
        HStack {
            if food.imageFilename != nil {
                getImageFromDocumentDirectory(filename: food.imageFilename!.components(separatedBy: ".")[0], fileExtension: food.imageFilename!.components(separatedBy: ".")[1], defaultFilename: "ImageUnavailable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100.0, height: 75.0)
            } else if food.imageUrl != "" {
                getImageFromUrl(url: food.imageUrl, defaultFilename: "ImageUnavailable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100.0, height: 75.0)
            }
           
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



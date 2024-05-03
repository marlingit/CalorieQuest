//
//  FavoriteItem.swift
//  CalorieQuest
//
//  Created by Group 11: Vijay Vadi, Brighton Young, and Marlin Spears.
//  Copyright © 2024 Vijay, Brighton, and Marlin. All rights reserved.
//

import SwiftUI

struct FoodItem: View {
    let food: Food
    var body: some View {
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        
        return HStack(spacing: 0) {
            if food.imageFilename != nil {
                getImageFromDocumentDirectory(filename: food.imageFilename!.components(separatedBy: ".")[0], fileExtension: food.imageFilename!.components(separatedBy: ".")[1], defaultFilename: "ImageUnavailable")
                    .resizable()
                    .frame(width: 100, height: 75)
                    .mask(RoundedRectangle(cornerRadius: 12))
                    .background(Color.black.opacity(0.25).mask(RoundedRectangle(cornerRadius: 12)))
            } else {
                getImageFromUrl(url: food.imageUrl, defaultFilename: "ImageUnavailable")
                    .resizable()
                    .frame(width: 100, height: 75)
                    .mask(RoundedRectangle(cornerRadius: 12))
                    .background(Color.black.opacity(0.25).mask(RoundedRectangle(cornerRadius: 12)))
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text(food.name)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                Text("\(formatter.string(from: food.servingSize as NSNumber) ?? "0.0") \(food.servingUnit)")
                    .font(.system(size: 15))
                    .fontWeight(.medium)
                    .padding(.top, 4)
            }.padding(.leading, 12)
            
            Spacer()
        }
    }
}

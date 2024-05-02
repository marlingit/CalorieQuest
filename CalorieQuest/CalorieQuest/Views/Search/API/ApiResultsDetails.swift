//
//  ApiResultsDetails.swift
//  CalorieQuest
//
//  Created by Brighton Young on 5/2/24.
//  Copyright © 2024 Marlin Spears. All rights reserved.
//

import SwiftUI

struct ApiResultsDetails: View {
    let food: FoodStruct
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        
        return VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                Text(food.name.components(separatedBy: " ")
                    .map { $0.capitalized }
                    .joined(separator: " "))
                    .foregroundStyle(.black)
                    .font(.custom("Urbanist", size: 24))
                    .fontWeight(.heavy)
                
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .fontWeight(.heavy)
                        .foregroundStyle(.black)
                        .frame(width: 25)
                }
                .padding(.top, 4)
            }
            .frame(maxWidth: .infinity)
            .padding(.leading, 24)
            .padding(.trailing, 24)
            .padding(.top, 12)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Food Item Image")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        getImageFromUrl(url: food.imageUrl, defaultFilename: "ImageUnavailable")
                            .resizable()
                            .frame(width: 300, height: 175)
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Calorie Count")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        if let calorieNutrient = food.nutrients.first(where: { $0.name.lowercased() == "calories" }) {
                            Text("\(formatter.string(from: calorieNutrient.amount as NSNumber) ?? "0.0") \(calorieNutrient.unit)")
                                .font(.system(size: 18))
                                .fontWeight(.heavy)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                                .padding(.top, 8)
                        } else {
                            Text("N/A")
                                .font(.system(size: 18))
                                .fontWeight(.heavy)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                                .padding(.top, 8)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Serving Size")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        Text("\(food.servingSize) \(food.servingUnit)")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    
                    // Add more details for other nutrients
                    ForEach(food.nutrients.filter { $0.name.lowercased() != "calories" }, id: \.name) { nutrient in
                        VStack(alignment: .leading, spacing: 0) {
                            Text(nutrient.name.components(separatedBy: " ")
                                .map { $0.capitalized }
                                .joined(separator: " "))
                                .font(.system(size: 18))
                                .fontWeight(.heavy)
                            
                            Text("\(formatter.string(from: nutrient.amount as NSNumber) ?? "0.0") \(nutrient.unit)")
                                .font(.system(size: 18))
                                .fontWeight(.heavy)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                                .padding(.top, 8)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 24)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 24)
                .padding(.trailing, 24)
                .padding(.top, 24)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.top, 12)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

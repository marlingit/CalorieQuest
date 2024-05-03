//
//  DatabaseResultsDetails.swift
//  CalorieQuest
//
//  Created by Brighton Young on 5/2/24.
//  Copyright © 2024 Marlin Spears. All rights reserved.
//

import SwiftUI

struct DatabaseResultsDetails: View {
    let food: Food
    var body: some View {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        
        return VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                Text(food.name)
                    .foregroundStyle(.black)
                    .font(.custom("Urbanist", size: 24))
                    .fontWeight(.heavy)
                
                Spacer()
                
            }.frame(maxWidth: .infinity)
                .padding(.leading, 24)
                .padding(.trailing, 24)
                .padding(.top, 0)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Food Item Image")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        if food.imageFilename != nil {
                            getImageFromDocumentDirectory(filename: food.imageFilename!.components(separatedBy: ".")[0], fileExtension: food.imageFilename!.components(separatedBy: ".")[1], defaultFilename: "ImageUnavailable")
                                .resizable()
                                .frame(width: 300, height: 175)
                                .padding()
                                .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                                .padding(.top, 8)
                        } else if food.imageUrl != "" {
                            getImageFromUrl(url: food.imageUrl, defaultFilename: "ImageUnavailable")
                                .resizable()
                                .frame(width: 300, height: 175)
                                .padding()
                                .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                                .padding(.top, 8)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Calorie Count")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        if let cal = food.nutrients?.first(where: {$0.name.lowercased() == "calories"}) {
                            Text("\(formatter.string(from: cal.amount as NSNumber) ?? "0.0") \(cal.unit)")
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
                        Text("Total Fat")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        if let cal = food.nutrients?.first(where: {$0.name.lowercased() == "total fat"}) {
                            Text("\(formatter.string(from: cal.amount as NSNumber) ?? "0.0") \(cal.unit)")
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
                        Text("Saturated Fat")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        if let cal = food.nutrients?.first(where: {$0.name.lowercased() == "saturated fat"}) {
                            Text("\(formatter.string(from: cal.amount as NSNumber) ?? "0.0") \(cal.unit)")
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
                        Text("Cholesterol")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        if let cal = food.nutrients?.first(where: {$0.name.lowercased() == "cholesterol"}) {
                            Text("\(formatter.string(from: cal.amount as NSNumber) ?? "0.0") \(cal.unit)")
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
                        Text("Sodium")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        if let cal = food.nutrients?.first(where: {$0.name.lowercased() == "sodium"}) {
                            Text("\(formatter.string(from: cal.amount as NSNumber) ?? "0.0") \(cal.unit)")
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
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 24)
                    .padding(.trailing, 24)
                    .padding(.top, 24)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 12)
            
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

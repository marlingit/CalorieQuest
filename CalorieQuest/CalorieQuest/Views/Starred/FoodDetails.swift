//
//  FoodDetails.swift
//  CalorieQuest
//
//  Created by Marlin on 5/1/24.
//  Copyright © 2024 Marlin Spears. All rights reserved.
//

import SwiftUI

struct FoodDetails: View {
    
    @Binding var detailsViewSelected: Int
    @Binding var sheetActive: Bool
       
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
                   
                   Button {
                       detailsViewSelected = 0
                       sheetActive = false
                   } label: {
                       Image(systemName: "xmark")
                           .resizable()
                           .scaledToFit()
                           .fontWeight(.heavy)
                           .foregroundStyle(.black)
                           .frame(width: 25)
                   }
                   .padding(.top, 4)
                   
               }.frame(maxWidth: .infinity)
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
                           
                           Text("25 Grams")
                               .font(.system(size: 18))
                               .fontWeight(.heavy)
                               .frame(maxWidth: .infinity)
                               .padding()
                               .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                               .padding(.top, 8)
                       }
                       .frame(maxWidth: .infinity, alignment: .leading)
                       .padding(.top, 24)
                       
                       VStack(alignment: .leading, spacing: 0) {
                           Text("Protein")
                               .font(.system(size: 18))
                               .fontWeight(.heavy)
                           
                           Text("80 Grams")
                               .font(.system(size: 18))
                               .fontWeight(.heavy)
                               .frame(maxWidth: .infinity)
                               .padding()
                               .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                               .padding(.top, 8)
                       }
                       .frame(maxWidth: .infinity, alignment: .leading)
                       .padding(.top, 24)
                       
                       VStack(alignment: .leading, spacing: 0) {
                           Text("Carbohydrates")
                               .font(.system(size: 18))
                               .fontWeight(.heavy)
                           
                           Text("40 Grams")
                               .font(.system(size: 18))
                               .fontWeight(.heavy)
                               .frame(maxWidth: .infinity)
                               .padding()
                               .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                               .padding(.top, 8)
                       }
                       .frame(maxWidth: .infinity, alignment: .leading)
                       .padding(.top, 24)
                       
                       VStack(alignment: .leading, spacing: 0) {
                           Text("Serving Size")
                               .font(.system(size: 18))
                               .fontWeight(.heavy)
                           
                           Text("20 Grams")
                               .font(.system(size: 18))
                               .fontWeight(.heavy)
                               .frame(maxWidth: .infinity)
                               .padding()
                               .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                               .padding(.top, 8)
                       }
                       .frame(maxWidth: .infinity, alignment: .leading)
                       .padding(.top, 24)
                       
                       HStack {
                           Spacer()
                           
                           Button {
                               
                           } label: {
                               Text("Remove from Favorites")
                                   .font(.system(size: 18))
                                   .fontWeight(.bold)
                                   .foregroundStyle(.white)
                                   .padding()
                                   .background(Color.black, in: RoundedRectangle(cornerRadius: 25))
                           }.padding(.top, 24)
                           
                           Spacer()
                           
                       }
                       
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


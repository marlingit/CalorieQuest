//
//  DailyGoalView.swift
//  CalorieQuest
//
//  Created by Vijay Vadi on 5/1/24.
//

import SwiftUI

struct DailyGoalView: View {
    
    @Binding var detailsViewSelected: Int
    @Binding var sheetActive: Bool
    
    @AppStorage("calorieTarget") var calories: String = "Set Goal"
    @AppStorage("carbohydrateTarget") var carbohydrates: String = ""
    @AppStorage("proteinTarget") var proteins: String = ""
    @AppStorage("fatTarget") var fats: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                
                Button {
                    
                } label: {
                    Image(systemName: "")
                        .resizable()
                        .scaledToFit()
                        .fontWeight(.heavy)
                        .foregroundStyle(.black)
                        .frame(width: 25)
                }
                .padding(.top, 4)
                
                Spacer()
                
                Text("Daily Goal")
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
            
            Text("Adjusting this will set your global calorie target for the day.")
                .font(.custom("Urbanist", size: 15))
                .fontWeight(.heavy)
                .padding(.top, 24)
                .padding(.leading, 24)
                .padding(.trailing, 24)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Calories")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        TextField("Calories", text: $calories)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Carbohydrates")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        TextField("Carbohydrates", text: $carbohydrates)
                            .font(.system(size: 18))
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
                        
                        TextField("Protein", text: $proteins)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Fat")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        TextField("Fat", text: $fats)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            UserDefaults.standard.set(proteins, forKey: "proteinTarget")
                            UserDefaults.standard.set(fats, forKey: "fatTarget")
                            UserDefaults.standard.set(calories, forKey: "calorieTarget")
                            UserDefaults.standard.set(carbohydrates, forKey: "carbohydrateTarget")
                        } label: {
                            Text("Save")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color.black, in: RoundedRectangle(cornerRadius: 25))
                        }
                        
                        Spacer()
                        
                    }.padding(.top, 12)
                    
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

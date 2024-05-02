//
//  AddManuallyView.swift
//  CalorieQuest
//
//  Created by Vijay Vadi on 5/1/24.
//

import SwiftUI

struct AddManuallyView: View {
    
    @Binding var detailsViewSelected: Int
    @Binding var sheetActive: Bool
    
    @State var foodName: String = ""
    @State var calories: String = ""
    
    @State var fat: String = ""
    @State var carbohydrates: String = ""
    
    @State private var selectedDate = Date()
    
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
                
                Text("Add Food")
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
                        Text("Food Item Name")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        TextField("Item Name", text: $foodName)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Calorie Count")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        TextField("Calories", text: $calories)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Total Fat")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        TextField("Fat", text: $fat)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Total Carbohydrates")
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
                        Text("Date and Time")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        DatePicker(
                            "",
                            selection: $selectedDate,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Text("Track Item")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color.black, in: RoundedRectangle(cornerRadius: 25))
                        }
                        
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

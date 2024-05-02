//
//  HomeView.swift
//  CalorieQuest
//
//  Created by Vijay Vadi on 4/30/24.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("firstname") var firstName: String = "Vijay"
    
    @AppStorage("calorieTarget") var calorieTarget: String = ""
    @AppStorage("caloriesCurrent") var caloriesCurrent: String = "1400"
    
    @Binding var profileBottomSheetActive: Bool
    @Binding var trackBottomSheetActive: Bool
    
    @State private var currentDate = Date()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 0) {
                Text("Hi \(firstName),\nLet's get started!")
                    .foregroundStyle(.black)
                    .font(.custom("Urbanist", size: 24))
                    .fontWeight(.heavy)
                
                Spacer()
                
                Button {
                    withAnimation {
                        profileBottomSheetActive.toggle()
                    }
                } label: {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.black)
                        .frame(width: 40)
                }
                .padding(.top, 4)
            }.frame(maxWidth: .infinity)
                .padding(.leading, 24)
                .padding(.trailing, 24)
                .padding(.top, 12)
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Dashboard")
                        .foregroundStyle(.black)
                        .font(.custom("Urbanist", size: 24))
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.leading)
                    
                    ZStack {
                        HStack(spacing: 0) {
                            ActivityRingView(progress: 0.7)
                                .frame(width: 50, height: 50)
                                .padding(.leading, 50)
                            
                            Spacer()
                            
                            VStack(spacing: 0) {
                                HStack(spacing: 0) {
                                    Text("\(caloriesCurrent)/\(calorieTarget)")
                                        .foregroundStyle(.black)
                                        .font(.custom("Urbanist", size: 24))
                                        .fontWeight(.heavy)
                                        .padding(.leading, 12)
                                    
                                    Spacer()
                                }
                                
                                HStack(spacing: 0) {
                                    Text("Calories Today")
                                        .foregroundStyle(.black)
                                        .font(.custom("Urbanist", size: 24))
                                        .fontWeight(.bold)
                                        .padding(.top, 8)
                                        .padding(.leading, 12)
                                    
                                    Spacer()
                                }
                            }
                            
                        }
                    }.frame(height: 100)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.black.opacity(0.25), lineWidth: 4)
                        )
                        .padding(.top, 12)
                    
                    HStack(spacing: 0) {
                        Button {
                            withAnimation() {
                                trackBottomSheetActive = true
                            }
                        } label: {
                            HStack(spacing: 0) {
                                Image(systemName: "flame")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.orange)
                                    .frame(width: 20)
                                
                                Text("Track")
                                    .foregroundStyle(.white)
                                    .font(.custom("Urbanist", size: 18))
                                    .fontWeight(.bold)
                                    .padding(.leading, 8)
                                
                            }
                            .padding(.leading, 15)
                            .padding(.trailing, 15)
                            .frame(height: 50)
                            .background(Color.black, in: RoundedRectangle(cornerRadius: 12))
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            HStack(spacing: 0) {
                                Image(systemName: "doc.text.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.black)
                                    .frame(width: 20)
                                
                                Text("Generate Report")
                                    .foregroundStyle(.black)
                                    .font(.custom("Urbanist", size: 18))
                                    .fontWeight(.bold)
                                    .padding(.leading, 8)
                                
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.black.opacity(0.25), in: RoundedRectangle(cornerRadius: 12))
                        }
                        .padding(.leading, 4)
                    }
                    .padding(.top, 8)
                    
                    Text("History")
                        .foregroundStyle(.black)
                        .font(.custom("Urbanist", size: 24))
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 24)
                    
                    VStack(spacing: 0) {
                        HStack {
                            Button(action: {
                                currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate
                            }) {
                                Image(systemName: "arrow.left")
                                    .font(.system(size: 24))
                                    .fontWeight(.heavy)
                            }
                            
                            Text(dateFormatter.string(from: currentDate))
                                .frame(minWidth: 200)
                                .foregroundStyle(.black)
                                .font(.custom("Urbanist", size: 18))
                                .fontWeight(.heavy)
                            
                            HStack {
                                if !Calendar.current.isDateInToday(currentDate) {
                                    Button(action: {
                                        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
                                        if tomorrow <= Date() {
                                            currentDate = tomorrow
                                        }
                                    }) {
                                        Image(systemName: "arrow.right")
                                            .font(.system(size: 24))
                                            .fontWeight(.heavy)
                                    }
                                }
                            }
                            .frame(width: 24)
                        }
                        .padding()
                        
                        Text("No data available")
                            .foregroundStyle(.black)
                            .font(.custom("Urbanist", size: 18))
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 12)
                            .padding(.bottom, 24)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.top, 12)
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 24)
                    .padding(.trailing, 24)
                    .padding(.top, 24)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

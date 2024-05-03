//
//  HomeView.swift
//  CalorieQuest
//
//  Created by Vijay Vadi on 4/30/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @AppStorage("firstname") var firstName: String = ""
    
    @AppStorage("calorieTarget") var calorieTarget: String = "Set Goal"
    @AppStorage("lastResetDateString") var lastResetDateString: String = ""
    
    @Binding var detailsViewSelected: Int
    @Binding var sheetActive: Bool
    
    @State private var caloriesCurrent = ""
    
    var lastResetDate: Date {
        guard !lastResetDateString.isEmpty else {
            return Date()
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: lastResetDateString) ?? Date()
    }
    
    @Binding var profileBottomSheetActive: Bool
    @Binding var trackBottomSheetActive: Bool
    
    @Environment(\.modelContext) private var modelContext
    @Query(FetchDescriptor<Day>(sortBy: [SortDescriptor(\Day.date, order: .forward)])) private var listOfAllDaysInDatabase: [Day]
    
    @State private var currentDate = Date()
    
    @State private var currentDay = Day(date: "", tracked: [Tracked]())
    
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
                                    Text("\(caloriesCurrent) / \(calorieTarget)")
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
                            withAnimation() {
                                detailsViewSelected = 9
                                sheetActive = true
                            }
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
                                currentDay = getDay(aDate: currentDate)
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
                                        currentDay = getDay(aDate: currentDate)
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
                        
                        if currentDay.date == "" {
                            Text("No data available")
                                .foregroundStyle(.black)
                                .font(.custom("Urbanist", size: 18))
                                .fontWeight(.heavy)
                                .multilineTextAlignment(.leading)
                                .padding(.top, 12)
                                .padding(.bottom, 24)
                        } else {
                            historyView
                            .foregroundStyle(.black)
                            .font(.custom("Urbanist", size: 18))
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 12)
                            .padding(.bottom, 24)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.top, 12)
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 24)
                    .padding(.trailing, 24)
                    .padding(.top, 24)
                    .onChange(of: currentDate) { _ in
                        if !Calendar.current.isDate(lastResetDate, inSameDayAs: currentDate) {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            lastResetDateString = dateFormatter.string(from: currentDate)
                        }
                    }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            caloriesCurrent = calcCurrent()
        }
    }
    
    func getDay(aDate: Date) -> Day {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let day = listOfAllDaysInDatabase.first(where: { $0.date == dateFormatter.string(from: aDate) }) {
            return day
        }
        
        
        return Day(date: "", tracked: [Tracked]())
    }
    
    func calcCurrent() -> String {
        let day = getDay(aDate: Date())
        var count = 0.0
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        
        for aTracked in day.tracked ?? [Tracked]() {
            for aFood in aTracked.foods ?? [Food]() {
                if let cal = aFood.nutrients!.first(where: { $0.name.lowercased() == "calories"}) {
                    if cal.unit == "kcal" {
                        count += cal.amount / 1000
                    } else {
                        count += cal.amount
                    }
                }
            }
        }
        UserDefaults.standard.set(count, forKey: "caloriesCurrent")
        return formatter.string(from: count as NSNumber) ?? "0.0"
    }
    
    var historyView: some View {
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        
        
        
        return LazyVStack {
            Text(calcCurrent())
            ForEach(currentDay.tracked!.sorted(by: { $0.time < $1.time }), id: \.self) { aTracked in
                Text(aTracked.time)
                VStack {
                    Text(aTracked.category)
                    
                    LazyVStack {
                        ForEach(aTracked.foods!, id: \.self) { aFood in
                            HStack {
                                Text(aFood.name)
                                if let cal = aFood.nutrients!.first(where: { $0.name.lowercased() == "calories"}) {
                                    Text("\(formatter.string(from: cal.amount as NSNumber) ?? "0.0") \(cal.unit)")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

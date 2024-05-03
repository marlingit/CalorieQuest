//
//  AddManuallyView.swift
//  CalorieQuest
//
//  Created by Vijay Vadi on 5/1/24.
//

import SwiftUI
import SwiftData

fileprivate let selectCategories = ["Breakfast", "Lunch", "Dinner", "Snack"]


struct AddManuallyView: View {
    @AppStorage("caloriesCurrent") private var caloriesCurrent: String = "0"
    @Environment(\.modelContext) private var modelContext
    
    @Binding var detailsViewSelected: Int
    @Binding var sheetActive: Bool
    
    @State var foodName: String = ""
    @State var calories: String = ""
    
    @State var fat: String = ""
    @State var satFat: String = ""
    @State var cholesterol: String = ""
    @State var sodium: String = ""
    @State var carbohydrates: String = ""
    
    @State var selectedIndex = 0
    @State private var selectedDate = Date()
    
    @State private var showAlertMessage = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }
    
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
                        Text("Select Category")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        Picker("", selection: $selectedIndex) {
                            ForEach(0 ..< selectCategories.count, id: \.self) {
                                Text(selectCategories[$0])
                            }
                        }
                        .font(.system(size: 18))
                        .padding()
                        .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                        .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Calorie Count")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        TextField("Calories", text: $calories)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                            .keyboardType(.decimalPad)
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
                            .keyboardType(.decimalPad)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Saturated Fat")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        TextField("Saturated Fat", text: $satFat)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                            .keyboardType(.decimalPad)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Cholesterol")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        TextField("Cholesterol", text: $cholesterol)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                            .keyboardType(.decimalPad)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Sodium")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        TextField("Sodium", text: $sodium)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                            .keyboardType(.decimalPad)
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
                            .keyboardType(.decimalPad)
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
                            if isValidated() {
                                saveTracked()
                                
                                showAlertMessage = true
                                alertTitle = "New Tracked Saved!"
                                alertMessage = "Your new tracked is successfully saved in the database!"
                            } else {
                                showAlertMessage = true
                                alertTitle = "Incorrect Data!"
                                alertMessage = "Please ensure all fields are filled correctly!"
                            }
                        } label: {
                            Text("Track Item")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color.black, in: RoundedRectangle(cornerRadius: 25))
                        }
                        .alert(alertTitle, isPresented: $showAlertMessage, actions: {
                            Button("OK") {
                                if alertTitle == "New Tracked Saved!" {
                                    detailsViewSelected = 0
                                    sheetActive = false
                                }
                            }
                        }, message: {
                            Text(alertMessage)
                        })
                        
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
    
    func isValidated() -> Bool {
        if foodName.isEmpty || calories.isEmpty || fat.isEmpty || satFat.isEmpty || cholesterol.isEmpty || sodium.isEmpty || carbohydrates.isEmpty {
            return false
        }
        
        if Double(calories) == nil || Double(fat) == nil || Double(cholesterol) == nil || Double(sodium) == nil || Double(carbohydrates) == nil {
            return false
        }
        
        return true
    }
    
    func saveTracked() {
        
        let dateString = dateFormatter.string(from: selectedDate)
        let timeString = timeFormatter.string(from: selectedDate)
        
        var dayArray = [Day]()
        
        var dayPredicate = #Predicate<Day> {
            $0.date == dateString
        }
        
        let fetchDescriptor = FetchDescriptor<Day>(
            predicate: dayPredicate,
            sortBy: [SortDescriptor(\Day.date, order: .forward)]
        )
        
        do {
            dayArray = try modelContext.fetch(fetchDescriptor)
        } catch {
            fatalError("Unable to fetch data from the database")
        }
        
        if dayArray.isEmpty {
            let newDay = Day(
                date: dateString,
                tracked: [Tracked]()
            )
            
            modelContext.insert(newDay)
            
            let newTracked = Tracked(
                category: selectCategories[selectedIndex],
                time: timeString,
                foods: [Food]()
            )
            
            newDay.tracked?.append(newTracked)
            
            let newFood = Food(
                name: foodName,
                itemId: "1",
                imageUrl: "",
                servingSize: 0.0,
                servingUnit: "",
                nutrients: [Nutrient]()
            )
            
            newTracked.foods?.append(newFood)
            
            let calNutrient = Nutrient(
                name: "calories",
                amount: Double(calories)!,
                unit: "cal",
                foods: [Food]()
            )
            
            calNutrient.foods?.append(newFood)
            
            let fatNutrient = Nutrient(
                name: "total fat",
                amount: Double(fat)!,
                unit: "g",
                foods: [Food]()
            )
            
            fatNutrient.foods?.append(newFood)
            
            let satFatNutrient = Nutrient(
                name: "saturated fat",
                amount: Double(satFat)!,
                unit: "g",
                foods: [Food]()
            )
            
            satFatNutrient.foods?.append(newFood)
            
            let cholesNutrient = Nutrient(
                name: "cholesterol",
                amount: Double(cholesterol)!,
                unit: "mg",
                foods: [Food]()
            )
            
            cholesNutrient.foods?.append(newFood)
            
            let sodiumNutrient = Nutrient(
                name: "sodium",
                amount: Double(sodium)!,
                unit: "mg",
                foods: [Food]()
            )
            
            sodiumNutrient.foods?.append(newFood)
            
            let carbNutrient = Nutrient(
                name: "total carbohydrate",
                amount: Double(carbohydrates)!,
                unit: "g",
                foods: [Food]()
            )
            
            carbNutrient.foods?.append(newFood)
            
            newFood.nutrients?.append(calNutrient)
            newFood.nutrients?.append(fatNutrient)
            newFood.nutrients?.append(satFatNutrient)
            newFood.nutrients?.append(cholesNutrient)
            newFood.nutrients?.append(sodiumNutrient)
            newFood.nutrients?.append(calNutrient)
        } else {
            let day = dayArray[0]
            
            let newTracked = Tracked(
                category: selectCategories[selectedIndex],
                time: timeString,
                foods: [Food]()
            )
            
            day.tracked?.append(newTracked)
            
            let newFood = Food(
                name: foodName,
                itemId: "1",
                imageUrl: "",
                servingSize: 0.0,
                servingUnit: "",
                nutrients: [Nutrient]()
            )
            
            newTracked.foods?.append(newFood)
            
            let calNutrient = Nutrient(
                name: "calories",
                amount: Double(calories)!,
                unit: "cal",
                foods: [Food]()
            )
            
            calNutrient.foods?.append(newFood)
            
            let fatNutrient = Nutrient(
                name: "total fat",
                amount: Double(fat)!,
                unit: "g",
                foods: [Food]()
            )
            
            fatNutrient.foods?.append(newFood)
            
            let satFatNutrient = Nutrient(
                name: "saturated fat",
                amount: Double(satFat)!,
                unit: "g",
                foods: [Food]()
            )
            
            satFatNutrient.foods?.append(newFood)
            
            let cholesNutrient = Nutrient(
                name: "cholesterol",
                amount: Double(cholesterol)!,
                unit: "mg",
                foods: [Food]()
            )
            
            cholesNutrient.foods?.append(newFood)
            
            let sodiumNutrient = Nutrient(
                name: "sodium",
                amount: Double(sodium)!,
                unit: "mg",
                foods: [Food]()
            )
            
            sodiumNutrient.foods?.append(newFood)
            
            let carbNutrient = Nutrient(
                name: "carbohydrate",
                amount: Double(carbohydrates)!,
                unit: "g",
                foods: [Food]()
            )
            
            carbNutrient.foods?.append(newFood)
            
            newFood.nutrients?.append(calNutrient)
            newFood.nutrients?.append(fatNutrient)
            newFood.nutrients?.append(satFatNutrient)
            newFood.nutrients?.append(cholesNutrient)
            newFood.nutrients?.append(sodiumNutrient)
            newFood.nutrients?.append(calNutrient)
        }
        
        var totalCaloriesConsumed: Double = 0.0
        dayArray.forEach { day in
            day.tracked?.forEach { tracked in
                tracked.foods?.forEach { food in
                    food.nutrients?.forEach { nutrient in
                        if nutrient.name == "calories" {
                            totalCaloriesConsumed += nutrient.amount
                        }
                    }
                }
            }
        }
        
        // Update the caloriesCurrent value
        caloriesCurrent = String(format: "%.0f", totalCaloriesConsumed)
        
        do {
            try modelContext.save()
        } catch {
            fatalError("Unable to save database changes")
        }
    }
}

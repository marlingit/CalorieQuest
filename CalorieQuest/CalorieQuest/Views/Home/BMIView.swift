//
//  BMIView.swift
//  CalorieQuest
//
//  Created by Vijay Vadi and Brighton Young on 5/1/24.
//

import SwiftUI

enum UnitSystem {
    case imperial
    case metric
}

struct BMIView: View {
    @Binding var detailsViewSelected: Int
    @Binding var sheetActive: Bool
    
    @AppStorage("weight") var weight: String = ""
    @AppStorage("height") var height: String = ""
    
    @State private var unitSystem: UnitSystem = .imperial
    @State private var showBMIResult: Bool = false
    @State private var bmiValue: Double = 0.0
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                Button {
                    // Add action for back button if needed
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .fontWeight(.heavy)
                        .foregroundStyle(.black)
                        .frame(width: 25)
                }
                .padding(.top, 4)
                
                Spacer()
                
                Text("Calculate BMI")
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
            }
            .frame(maxWidth: .infinity)
            .padding(.leading, 24)
            .padding(.trailing, 24)
            .padding(.top, 12)
            
            Text("Your Height & Weight data has been imported from your entered data. You can adjust the values here temporarily. To change these values permanently, visit settings.")
                .font(.custom("Urbanist", size: 15))
                .fontWeight(.heavy)
                .padding(.top, 24)
                .padding(.leading, 24)
                .padding(.trailing, 24)
            
            Picker("Unit System", selection: $unitSystem) {
                Text("Imperial").tag(UnitSystem.imperial)
                Text("Metric").tag(UnitSystem.metric)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(unitSystem == .imperial ? "Height (Inches)" : "Height (Centimeters)")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        TextField("Height", text: $height)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(unitSystem == .imperial ? "Weight (Pounds)" : "Weight (Kilograms)")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        TextField("Weight", text: $weight)
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
                            calculateBMI()
                        } label: {
                            Text("Calculate")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color.black, in: RoundedRectangle(cornerRadius: 25))
                        }
                        
                        Spacer()
                    }.padding(.top, 12)
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
        .sheet(isPresented: $showBMIResult) {
            BMIResultView(bmiValue: bmiValue, unitSystem: unitSystem)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func calculateBMI() {
        guard let heightValue = Double(height),
              let weightValue = Double(weight) else {
            alertTitle = "Invalid Input"
            alertMessage = "Please enter valid height and weight values."
            showAlert = true
            return
        }
        
        guard heightValue > 0 && weightValue > 0 else {
            alertTitle = "Invalid Input"
            alertMessage = "Height and weight must be greater than 0."
            showAlert = true
            return
        }
        
        let heightInMeters = unitSystem == .imperial ? heightValue * 0.0254 : heightValue / 100
        let weightInKilograms = unitSystem == .imperial ? weightValue * 0.45359237 : weightValue
        
        bmiValue = weightInKilograms / (heightInMeters * heightInMeters)
        showBMIResult = true
    }
}

struct BMIResultView: View {
    let bmiValue: Double
    let unitSystem: UnitSystem
    
    var bmiCategory: String {
        if bmiValue < 18.5 {
            return "Underweight"
        } else if bmiValue < 25 {
            return "Healthy"
        } else if bmiValue < 30 {
            return "Overweight"
        } else {
            return "Obese"
        }
    }
    
    var body: some View {
        VStack {
            Text("BMI Result")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Text("BMI: \(String(format: "%.2f", bmiValue))")
                .font(.title2)
                .padding()
            
            Text("Category: \(bmiCategory)")
                .font(.title2)
                .padding()
        }
    }
}

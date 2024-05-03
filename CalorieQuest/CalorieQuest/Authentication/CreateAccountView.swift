//
//  CreateAccount.swift
//  CalorieQuest
//
//  Created by Group 11: Vijay Vadi, Brighton Young, and Marlin Spears.
//  Copyright © 2024 Vijay, Brighton, and Marlin. All rights reserved.
//

import SwiftUI

struct CreateAccountView: View {
    
    @Binding var authenticationComplete: Bool
    
    @State var pagenumber: Int = 1
    
    var body: some View {
        VStack(spacing: 0) {
            if pagenumber == 1 {
                OnboardingOne(pagenumber: $pagenumber)
            } else if pagenumber == 2 {
                OnboardingTwo(pagenumber: $pagenumber)
            } else {
                OnboardingThree(pagenumber: $pagenumber, authenticationComplete: $authenticationComplete)
            }
            
            Spacer()
            
            Text("\(pagenumber)/3")
                .font(.custom("Urbanist", size: 18))
                .fontWeight(.heavy)
                .padding()
                .background(Color.black.opacity(0.25), in: RoundedRectangle(cornerRadius: 25))
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct OnboardingOne: View {
    
    @Binding var pagenumber: Int
    
    @State private var firstname: String = ""
    @State private var firstnameTextFieldEditingActive = false
    
    @State private var lastname: String = ""
    @State private var lastnameTextFieldEditingActive = false
    
    @State private var missingFieldAlertVisible = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Group {
                Text("Welcome,")
                    .foregroundStyle(.black)
                    .font(.custom("Urbanist", size: 28))
                    .fontWeight(.bold)
                    .padding(.top, 42)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("What's your name?")
                    .foregroundStyle(.black)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }.padding(.leading, 22)
            
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 4) {
                    TextField("First Name", text: $firstname, onEditingChanged: { (editingChanged) in
                        if editingChanged {
                            withAnimation {
                                firstnameTextFieldEditingActive = true
                                missingFieldAlertVisible = false
                            }
                        } else {
                            withAnimation {
                                firstnameTextFieldEditingActive = false
                                missingFieldAlertVisible = false
                            }
                        }
                    })
                    .foregroundStyle(.black)
                    .tint(.black)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .padding(.leading, 2)
                    .padding(.trailing, 12)
                    
                    Rectangle()
                        .foregroundColor(.black)
                        .opacity(firstnameTextFieldEditingActive ? 1 : 0.5)
                        .frame(height: 4)
                        .frame(maxWidth: .infinity)
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 4) {
                    TextField("Last Name", text: $lastname, onEditingChanged: { (editingChanged) in
                        if editingChanged {
                            withAnimation {
                                lastnameTextFieldEditingActive = true
                                missingFieldAlertVisible = false
                            }
                        } else {
                            withAnimation {
                                lastnameTextFieldEditingActive = false
                                missingFieldAlertVisible = false
                            }
                        }
                    })
                    .foregroundStyle(.black)
                    .tint(.black)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .padding(.leading, 2)
                    .padding(.trailing, 12)
                    
                    Rectangle()
                        .foregroundColor(.black)
                        .opacity(lastnameTextFieldEditingActive ? 1 : 0.5)
                        .frame(height: 4)
                        .frame(maxWidth: .infinity)
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 28)
                
                HStack(spacing: 0) {
                    
                    Button {
                        missingFieldAlertVisible = false
                        
                        if firstname.isEmpty || lastname.isEmpty {
                            missingFieldAlertVisible = true
                        } else {
                            
                            UserDefaults.standard.set(firstname, forKey: "firstname")
                            UserDefaults.standard.set(lastname, forKey: "lastname")
                            
                            withAnimation() {
                                // authenticationComplete = true
                                pagenumber = 2
                            }
                        }
                    } label: {
                        Text("Continue")
                            .foregroundStyle(.white)
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .frame(width: 150, height: 50)
                            .background(firstname.isEmpty || lastname.isEmpty ? Color.black.opacity(0.5) : Color.black, in: RoundedRectangle(cornerRadius: 50))
                    }.padding(.top, 24)
                    
                    Spacer()
                }
                
                if missingFieldAlertVisible {
                    Text("First Name & Last Name text fields required.")
                        .foregroundStyle(.red)
                        .font(.custom("Urbanist", size: 18))
                        .fontWeight(.bold)
                        .padding(.top, 12)
                }
                
                Spacer()
            }.padding(.leading, 22)
                .padding(.top, 48)
                .padding(.trailing, 74)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
struct OnboardingTwo: View {
    
    @Binding var pagenumber: Int
    
    @AppStorage("firstname") var firstName: String = ""
    
    @State private var heightFeet: String = ""
    @State private var heightFeetTextFieldEditingActive = false
    
    @State private var heightInches: String = ""
    @State private var heightInchesTextFieldEditingActive = false
    
    @State private var weight: String = ""
    @State private var weightTextFieldEditingActive = false
    
    @State private var missingFieldAlertVisible = false
    @State private var invalidInputAlertVisible = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                withAnimation() {
                    pagenumber = 1
                }
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color.black)
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .padding(.top, 12)
                    .frame(width: 50, height: 50)
            }
            
            Group {
                Text("Hello \(firstName),")
                    .foregroundStyle(.black)
                    .font(.custom("Urbanist", size: 28))
                    .fontWeight(.bold)
                    .padding(.top, 24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Let's tailor your experience.")
                    .foregroundStyle(.black)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }.padding(.leading, 22)
            
            VStack(spacing: 0) {
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        TextField("Feet", text: $heightFeet, onEditingChanged: { (editingChanged) in
                            if editingChanged {
                                withAnimation {
                                    heightFeetTextFieldEditingActive = true
                                    missingFieldAlertVisible = false
                                    invalidInputAlertVisible = false
                                }
                            } else {
                                withAnimation {
                                    heightFeetTextFieldEditingActive = false
                                    missingFieldAlertVisible = false
                                    invalidInputAlertVisible = false
                                }
                            }
                        })
                        .foregroundStyle(.black)
                        .tint(.black)
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.leading, 2)
                        .padding(.trailing, 12)
                        .keyboardType(.numberPad)
                        
                        Rectangle()
                            .foregroundColor(.black)
                            .opacity(heightFeetTextFieldEditingActive ? 1 : 0.5)
                            .frame(height: 4)
                            .frame(maxWidth: .infinity)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        TextField("Inches", text: $heightInches, onEditingChanged: { (editingChanged) in
                            if editingChanged {
                                withAnimation {
                                    heightInchesTextFieldEditingActive = true
                                    missingFieldAlertVisible = false
                                    invalidInputAlertVisible = false
                                }
                            } else {
                                withAnimation {
                                    heightInchesTextFieldEditingActive = false
                                    missingFieldAlertVisible = false
                                    invalidInputAlertVisible = false
                                }
                            }
                        })
                        .foregroundStyle(.black)
                        .tint(.black)
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.leading, 2)
                        .padding(.trailing, 12)
                        .keyboardType(.numberPad)
                        
                        Rectangle()
                            .foregroundColor(.black)
                            .opacity(heightInchesTextFieldEditingActive ? 1 : 0.5)
                            .frame(height: 4)
                            .frame(maxWidth: .infinity)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    TextField("Weight", text: $weight, onEditingChanged: { (editingChanged) in
                        if editingChanged {
                            withAnimation {
                                weightTextFieldEditingActive = true
                                missingFieldAlertVisible = false
                                invalidInputAlertVisible = false
                            }
                        } else {
                            withAnimation {
                                weightTextFieldEditingActive = false
                                missingFieldAlertVisible = false
                                invalidInputAlertVisible = false
                            }
                        }
                    })
                    .foregroundStyle(.black)
                    .tint(.black)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .padding(.leading, 2)
                    .padding(.trailing, 12)
                    .keyboardType(.numberPad)
                    
                    Rectangle()
                        .foregroundColor(.black)
                        .opacity(weightTextFieldEditingActive ? 1 : 0.5)
                        .frame(height: 4)
                        .frame(maxWidth: .infinity)
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 28)
                
                HStack(spacing: 0) {
                    Button {
                        missingFieldAlertVisible = false
                        invalidInputAlertVisible = false
                        
                        if heightFeet.isEmpty || heightInches.isEmpty || weight.isEmpty {
                            missingFieldAlertVisible = true
                        } else if let heightFeetValue = Int(heightFeet), let heightInchesValue = Int(heightInches), let weightValue = Int(weight) {
                            let heightInches = heightFeetValue * 12 + heightInchesValue
                            UserDefaults.standard.set(heightInches, forKey: "height")
                            UserDefaults.standard.set(weightValue, forKey: "weight")
                            
                            withAnimation() {
                                pagenumber = 3
                            }
                        } else {
                            invalidInputAlertVisible = true
                        }
                    } label: {
                        Text("Continue")
                            .foregroundStyle(.white)
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .frame(width: 150, height: 50)
                            .background(heightFeet.isEmpty || heightInches.isEmpty || weight.isEmpty ? Color.black.opacity(0.5) : Color.black, in: RoundedRectangle(cornerRadius: 50))
                    }.padding(.top, 24)
                    
                    Spacer()
                }
                
                if missingFieldAlertVisible {
                    Text("Height and Weight text fields required.")
                        .foregroundStyle(.red)
                        .font(.custom("Urbanist", size: 18))
                        .fontWeight(.bold)
                        .padding(.top, 12)
                }
                
                if invalidInputAlertVisible {
                    Text("Please enter valid numeric values for Height and Weight.")
                        .foregroundStyle(.red)
                        .font(.custom("Urbanist", size: 18))
                        .fontWeight(.bold)
                        .padding(.top, 12)
                }
                
                Spacer()
            }.padding(.leading, 22)
                .padding(.top, 48)
                .padding(.trailing, 74)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct OnboardingThree: View {
    
    @Binding var pagenumber: Int
    
    @Binding var authenticationComplete: Bool
    
    @AppStorage("firstname") var firstName: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                withAnimation() {
                    pagenumber = 2
                }
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color.black)
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .padding(.top, 12)
                    .frame(width: 50, height: 50)
            }
            
            Group {
                Text("You're Ready to Go!")
                    .foregroundStyle(.black)
                    .font(.custom("Urbanist", size: 28))
                    .fontWeight(.bold)
                    .padding(.top, 24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }.padding(.leading, 22)
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    
                    Button {
                        withAnimation() {
                            authenticationComplete = true
                        }
                    } label: {
                        Text("Let's Go!")
                            .foregroundStyle(.white)
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .frame(width: 150, height: 50)
                            .background(Color.black, in: RoundedRectangle(cornerRadius: 50))
                    }.padding(.top, 24)
                    
                    Spacer()
                }
                
                Spacer()
            }.padding(.leading, 22)
                .padding(.top, 48)
                .padding(.trailing, 74)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

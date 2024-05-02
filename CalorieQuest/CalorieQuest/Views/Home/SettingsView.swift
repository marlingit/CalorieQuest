//
//  SettingsView.swift
//  CalorieQuest
//
//  Created by Vijay Vadi on 5/1/24.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var detailsViewSelected: Int
    @Binding var sheetActive: Bool
    
    @AppStorage("firstname") var firstname: String = ""
    @AppStorage("lastname") var lastname: String = ""
    
    @AppStorage("weight") var weight: String = ""
    @AppStorage("height") var height: String = ""
    
    @AppStorage("gender") var gender: String = ""
    
    @State private var showAlert = false
    
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
                
                Text("Settings")
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
                        Text("First Name")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        TextField("First Name", text: $firstname)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Last Name")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        TextField("Last Name", text: $lastname)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Gender")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        Picker("Gender", selection: $gender) {
                            Text("Male").tag("Male")
                            Text("Female").tag("Female")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.top, 8)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Height")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        TextField("Height", text: $height)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Weight")
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
                            UserDefaults.standard.set(height, forKey: "height")
                            UserDefaults.standard.set(weight, forKey: "weight")
                            UserDefaults.standard.set(firstname, forKey: "firstname")
                            UserDefaults.standard.set(lastname, forKey: "lastname")
                            showAlert = true // Show the alert after saving data
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
            
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Changes Saved"),
                    message: Text("Your settings have been successfully saved."),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

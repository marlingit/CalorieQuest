//
//  SearchView.swift
//  CalorieQuest
//
//  Created by Vijay Vadi on 4/30/24.
//

import SwiftUI

struct SearchView: View {
    
    @State private var selectedOption: String = "Database"
    let options: [String] = ["Database", "API", "Videos DB"]
    
    @State private var searchFieldTextValue: String = ""
    @State private var searchCompleted = false
    
    @State private var showAlert = false
    @State private var showSearchResults = false
    @State private var showApiSearchResults = false
    @State private var showDatabaseSearchResults = false
    @State private var showVideoSearchResults = false

    @State private var showVideosList = false
    
    @State private var showAlertMessage = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                
                HStack(alignment: .top, spacing: 0) {
                    
                    Spacer()
                    
                    Text("Search")
                        .foregroundStyle(.black)
                        .font(.custom("Urbanist", size: 24))
                        .fontWeight(.heavy)
                    
                    Spacer()
                }.frame(maxWidth: .infinity)
                    .padding(.leading, 24)
                    .padding(.trailing, 24)
                    .padding(.top, 12)
                
                ScrollView {
                    VStack(spacing: 0) {
                        Spacer()
                        Image(selectedOption == "Database" ? "DatabaseSearchImage" :
                                selectedOption == "API" ? "ApiSearchImage" :
                                "VideoSearchImage")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .mask(Circle())
                        .background(Color.black.opacity(0.25).mask(Circle()))
                        Picker("Choose an option", selection: $selectedOption) {
                            ForEach(options, id: \.self) { option in
                                Text(option)
                                    .font(.custom("Urbanist", size: 18))
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.top, 24)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Search \(selectedOption)")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        TextField("Search", text: $searchFieldTextValue)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    
                    Button {
                        if inputDataValidated() {
                            if selectedOption == "Database" {
                                searchDB()
                                if databaseSearchResults.count == 0 {
                                    alertTitle = "No Results"
                                    alertMessage = "No food items found for the given search query \(searchQuery)."
                                    showAlertMessage = true // Show the alert
                                } else {
                                    showDatabaseSearchResults = true
                                }
                            }
                            if selectedOption == "API" {
                                searchApi()
                                
                                if foodArray.isEmpty {
                                    alertTitle = "No Results"
                                    alertMessage = "No food items found for the given search query \(searchQuery)."
                                    showAlertMessage = true
                                } else {
                                    showApiSearchResults = true
                                }
                            }
                            if selectedOption == "Videos DB" {
                                searchVideoDB()
                                if videoSearchResults.isEmpty {
                                    alertTitle = "No Results"
                                    alertMessage = "No food items found for the given search query \(searchQuery)."
                                    showAlertMessage = true
                                }
                                else {
                                    showVideoSearchResults = true
                                }
                            }
                        } else {
                            showAlertMessage = true
                            alertTitle = "Missing Input Data!"
                            alertMessage = "Please enter a database search query!"
                        }
                    } label: {
                        Text("Search")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color.black, in: RoundedRectangle(cornerRadius: 25))
                    }.padding(.top, 24)
                    
                    if selectedOption == "Videos DB" {
                        Button {
                            showVideosList = true
                        } label: {
                            Text("Show Videos List")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color.black, in: RoundedRectangle(cornerRadius: 25))
                                .fixedSize(horizontal: true, vertical: false)
                        }
                        .padding(.top, 24)
                    }
                }
            }
        }
        .sheet(isPresented: $showVideosList) {
            VideosList()
        }
        .sheet(isPresented: $showApiSearchResults) {
            ApiResultsList(foodArray: foodArray)
        }
        .sheet(isPresented: $showDatabaseSearchResults) {
            DatabaseResultsList(foodArray: databaseSearchResults)
        }
        .sheet(isPresented: $showVideoSearchResults) {
            VideoResultsList(videoArray: videoSearchResults)
        }
        .alert(alertTitle, isPresented: $showAlertMessage, actions: {
            Button("OK") {}
        }, message: {
            Text(alertMessage)
        })
    }
    
    /*
     ---------------------
     MARK: Search Database
     ---------------------
     */
    func searchDB() {
        // Remove spaces, if any, at the beginning and at the end of the entered search query string
        let queryTrimmed = searchFieldTextValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        searchQuery = queryTrimmed
        
        // Public function conductDatabaseSearch is given in DatabaseSearch.swift
        conductDatabaseSearch()
    }
    
    func searchApi() {
        let foodNameTrimmed = searchFieldTextValue.trimmingCharacters(in: .whitespacesAndNewlines)
        getNutritionDataFromName(name: foodNameTrimmed)
    }
    
    /*
     ---------------------------
     MARK: Input Data Validation
     ---------------------------
     */
    func inputDataValidated() -> Bool {
        // Remove spaces, if any, at the beginning and at the end of the entered search query string
        let queryTrimmed = searchFieldTextValue.trimmingCharacters(in: .whitespacesAndNewlines)
        if queryTrimmed.isEmpty {
            return false
        }
        return true
    }
    
    func searchVideoDB() {
        let queryTrimmed = searchFieldTextValue.trimmingCharacters(in: .whitespacesAndNewlines)
        videoSearchQuery = queryTrimmed
        conductVideoDatabaseSearch()
    }
}

#Preview {
    SearchView()
}

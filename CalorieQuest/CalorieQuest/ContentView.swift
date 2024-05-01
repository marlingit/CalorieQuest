//
//  ContentView.swift
//  CalorieQuest
//
//  Created by Vijay Vadi on 4/29/24.
//

import SwiftUI

struct ContentView: View {
    
    var namespace: Namespace.ID
    @Binding var authenticationComplete: Bool
    
    @State var selectedTab = 1
    
    @State private var detailsViewSelected: Int = 0
    
    @State var profileBottomSheetActive = false
    
    @State var trackBottomSheetActive = false
    
    @State var sheetActive = false
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    TabView(selection: $selectedTab) {
                        StarredView()
                            .tag(0)
                        
                        HomeView(profileBottomSheetActive: $profileBottomSheetActive, trackBottomSheetActive: $trackBottomSheetActive)
                            .tag(1)
                        
                        SearchView()
                            .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .mask(BottomRoundedRectangle(cornerRadius: 35))
                .background(
                    ZStack {
                        Color.white
                            .mask(BottomRoundedRectangle(cornerRadius: 36))
                    }.edgesIgnoringSafeArea(.top)
                        .ignoresSafeArea(.keyboard)
                        .matchedGeometryEffect(id: "view", in: namespace)
                )
                
                if detailsViewSelected == 0 {
                    MenuTabView(selectedTab: $selectedTab)
                        .padding(.top, 6)
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.bottom))
            
            BottomSheet(isShowing: $profileBottomSheetActive, content: AnyView(ProfileBottomSheet(detailsViewSelected: $detailsViewSelected, profileBottomSheetActive: $profileBottomSheetActive, sheetActive: $sheetActive)))
            
            BottomSheet(isShowing: $trackBottomSheetActive, content: AnyView(TrackBottomSheet(detailsViewSelected: $detailsViewSelected, trackBottomSheetActive: $trackBottomSheetActive, sheetActive: $sheetActive)))
        }
        .fullScreenCover(isPresented: $sheetActive) {
            if detailsViewSelected == 1 {
                BMIView(detailsViewSelected: $detailsViewSelected, sheetActive: $sheetActive)
            } else if detailsViewSelected == 2 {
                DailyGoalView(detailsViewSelected: $detailsViewSelected, sheetActive: $sheetActive)
            } else if detailsViewSelected == 3 {
                SettingsView(detailsViewSelected: $detailsViewSelected, sheetActive: $sheetActive)
            } else if detailsViewSelected == 6 {
                AddManuallyView(detailsViewSelected: $detailsViewSelected, sheetActive: $sheetActive)
            }
        }
    }
}

struct MenuTabView: View {
    
    @Binding var selectedTab: Int
    
    var body: some View {
        
        HStack(spacing: 75) {
            VStack(spacing: 0) {
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(height: 22.5)
                    .opacity(selectedTab == 0 ? 1 : 0.25)
                    .animation(.easeInOut, value: selectedTab)
                    .onTapGesture {
                        withAnimation {
                            selectedTab = 0
                        }
                    }
                
                Text("Starred")
                    .foregroundStyle(.white)
                    .font(.custom("Urbanist", size: 12))
                    .fontWeight(.bold)
                    .padding(.top, 4)
                    .opacity(selectedTab == 0 ? 1 : 0.25)
            }.frame(height: 50)
            
            VStack(spacing: 0) {
                Image(systemName: "house.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: 25)
                    .opacity(selectedTab == 1 ? 1 : 0.25)
                    .animation(.easeInOut, value: selectedTab)
                    .onTapGesture {
                        withAnimation {
                            selectedTab = 1
                        }
                    }
                
                Text("Home")
                    .foregroundStyle(.white)
                    .font(.custom("Urbanist", size: 12))
                    .fontWeight(.bold)
                    .padding(.top, 4)
                    .opacity(selectedTab == 1 ? 1 : 0.25)
            }.frame(height: 50)
            
            VStack(spacing: 0) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: 20)
                    .opacity(selectedTab == 2 ? 1 : 0.25)
                    .animation(.easeInOut, value: selectedTab)
                    .onTapGesture {
                        withAnimation {
                            selectedTab = 2
                        }
                    }
                
                Text("Search")
                    .foregroundStyle(.white)
                    .font(.custom("Urbanist", size: 12))
                    .fontWeight(.bold)
                    .padding(.top, 4)
                    .opacity(selectedTab == 2 ? 1 : 0.25)
            }.frame(height: 50)
            
        }.frame(height: 50)
        
    }
}

struct SettingsView: View {
    
    @Binding var detailsViewSelected: Int
    @Binding var sheetActive: Bool
    
    @AppStorage("firstname") var firstname: String = ""
    @AppStorage("lastname") var lastname: String = ""
    
    @AppStorage("weight") var weight: String = ""
    @AppStorage("height") var height: String = ""
    
    @AppStorage("gender") var gender: String = ""
    
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
                        
                        TextField("Gender", text: $gender)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
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

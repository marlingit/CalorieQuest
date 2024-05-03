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
                        StarredView(detailsViewSelected: $detailsViewSelected, sheetActive: $sheetActive)
                            .tag(0)
                        
                        HomeView(detailsViewSelected: $detailsViewSelected, sheetActive: $sheetActive, profileBottomSheetActive: $profileBottomSheetActive, trackBottomSheetActive: $trackBottomSheetActive)
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
            } else if detailsViewSelected == 4 {
                ScanQRBarcode(detailsViewSelected: $detailsViewSelected, sheetActive: $sheetActive)
            } else if detailsViewSelected == 5 {
                PickFromFavoritesView(detailsViewSelected: $detailsViewSelected, sheetActive: $sheetActive)
            } else if detailsViewSelected == 7 {
                AddFavoriteFoodView(detailsViewSelected: $detailsViewSelected, sheetActive: $sheetActive)
            } else if detailsViewSelected == 8 {
                FoodDetails(detailsViewSelected: $detailsViewSelected, sheetActive: $sheetActive)
            } else if detailsViewSelected == 9 {
                PDFDocView(detailsViewSelected: $detailsViewSelected, sheetActive: $sheetActive)
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

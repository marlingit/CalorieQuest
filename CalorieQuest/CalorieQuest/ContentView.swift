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
            } else if detailsViewSelected == 4 {
                ScanQRBarcode(detailsViewSelected: $detailsViewSelected, sheetActive: $sheetActive)
            } else if detailsViewSelected == 5 {
                
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

struct AddFavoriteFoodView: View {
    
    @Binding var detailsViewSelected: Int
    @Binding var sheetActive: Bool
    
    @State var foodName: String = ""
    @State var calories: String = ""
    
    @State var fat: String = ""
    @State var carbohydrates: String = ""
    
    @State private var selectedDate = Date()
    
    //------------------------------------
    // Image Picker from Camera or Library
    //------------------------------------
    @State private var showImagePicker = false
    @State private var pickedUIImage: UIImage?
    @State private var pickedImage: Image?
    
    @State private var useCamera = false
    @State private var usePhotoLibrary = true
    
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
                    
                    let camera = Binding(
                        get: { useCamera },
                        set: {
                            useCamera = $0
                            if $0 == true {
                                usePhotoLibrary = false
                            }
                        }
                    )
                    let photoLibrary = Binding(
                        get: { usePhotoLibrary },
                        set: {
                            usePhotoLibrary = $0
                            if $0 == true {
                                useCamera = false
                            }
                        }
                    )
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Item Picture")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        VStack {
                            Toggle("Use Camera", isOn: camera)
                            Toggle("Use Photo Library", isOn: photoLibrary)
                            
                            Button("Get Photo") {
                                showImagePicker = true
                            }
                            .tint(.blue)
                            .buttonStyle(.bordered)
                            .buttonBorderShape(.capsule)
                        }
                        
                        if pickedImage != nil {
                            Section(header: Text("Taken or Picked Photo")) {
                                pickedImage?
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100.0, height: 100.0)
                            }
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Text("Add Food")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color.black, in: RoundedRectangle(cornerRadius: 25))
                        }
                        
                        Spacer()
                        
                    }.padding(.top, 48)
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 24)
                    .padding(.trailing, 24)
                    .padding(.top, 24)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 12)
            
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .onChange(of: pickedUIImage) {
                guard let uiImagePicked = pickedUIImage else { return }
                
                // Convert UIImage to SwiftUI Image
                pickedImage = Image(uiImage: uiImagePicked)
            }
            .sheet(isPresented: $showImagePicker) {
                /*
                 For storage and performance efficiency reasons, we scale down the photo image selected from the
                 photo library or taken by the camera to a smaller size with imageWidth and imageHeight in points.
                 
                 For retina displays, 1 point = 3 pixels
                 
                 // Example: For HD aspect ratio of 16:9
                 width  = 500.00 points --> 1500.00 pixels
                 height = 281.25 points -->  843.75 pixels
                 
                 500/281.25 = 16/9 = 1500.00/843.75 = HD aspect ratio
                 
                 imageWidth =  500.0 points and imageHeight = 281.25 points will produce an image with
                 imageWidth = 1500.0 pixels and imageHeight = 843.75 pixels which is about 600 KB in JPG format.
                 */
                
                ImagePicker(
                    uiImage: $pickedUIImage,
                    sourceType: useCamera ? .camera : .photoLibrary,
                    imageWidth: 500.0,
                    imageHeight: 281.25
                )
            }
    }
}

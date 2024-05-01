//
//  BottomSheet.swift
//  CalorieQuest
//
//  Created by Vijay Vadi on 4/30/24.
//

import SwiftUI

struct ProfileBottomSheet: View{
    
    let buttonHeight: CGFloat = 55
    
    @Binding var detailsViewSelected: Int
    
    @Binding var profileBottomSheetActive: Bool
    
    @Binding var sheetActive: Bool
    
    var body: some View{
        VStack(alignment: .leading) {
            HStack {
                Text("Profile")
                    .foregroundColor(.black)
                    .font(.custom("Urbanist", size: 24))
                    .fontWeight(.heavy)

                Spacer()
                
                Button {
                    withAnimation() {
                        profileBottomSheetActive = false
                    }
                } label: {
                    Image(systemName: "chevron.down")
                        .resizable()
                        .foregroundStyle(Color.black)
                        .frame(width: 25, height: 15)
                        .fontWeight(.bold)
                }
            }
            .padding(.top, 24)
            .padding(.bottom, 12)
            .padding(.leading, 8)
            .padding(.trailing, 12)
            
            ButtonLarge(label: "Calculate BMI", action: {
                withAnimation() {
                    profileBottomSheetActive = false
                    detailsViewSelected = 1
                    sheetActive = true
                }
            })
            .frame(height: buttonHeight)
            
            ButtonLarge(label: "Set Daily Goal", action: {
                withAnimation() {
                    profileBottomSheetActive = false
                    detailsViewSelected = 2
                    sheetActive = true
                }
            })
            .frame(height: buttonHeight)
            .padding(.vertical, 2)
            
            ButtonLarge(label: "Settings", action: {
                withAnimation() {
                    profileBottomSheetActive = false
                    detailsViewSelected = 3
                    sheetActive = true
                }
            })
            .frame(height: buttonHeight)
            .padding(.vertical, 2)
        }
        .padding(.horizontal, 16)
    }
}

struct TrackBottomSheet: View{
    
    let buttonHeight: CGFloat = 55
    
    @Binding var detailsViewSelected: Int
    
    @Binding var trackBottomSheetActive: Bool
    
    @Binding var sheetActive: Bool
    
    var body: some View{
        VStack(alignment: .leading) {
            HStack {
                Text("Track")
                    .foregroundColor(.black)
                    .font(.custom("Urbanist", size: 24))
                    .fontWeight(.heavy)

                Spacer()
                
                Button {
                    withAnimation() {
                        trackBottomSheetActive = false
                    }
                } label: {
                    Image(systemName: "chevron.down")
                        .resizable()
                        .foregroundStyle(Color.black)
                        .frame(width: 25, height: 15)
                        .fontWeight(.bold)
                }
            }
            .padding(.top, 24)
            .padding(.bottom, 12)
            .padding(.leading, 8)
            .padding(.trailing, 12)
            
            ButtonLarge(label: "Scan Barcode", action: {
                withAnimation() {
                    trackBottomSheetActive = false
                    detailsViewSelected = 4
                    sheetActive = true
                }
            })
            .frame(height: buttonHeight)
            
            ButtonLarge(label: "Choose from Saved", action: {
                withAnimation() {
                    trackBottomSheetActive = false
                    detailsViewSelected = 5
                    sheetActive = true
                }
            })
            .frame(height: buttonHeight)
            .padding(.vertical, 2)
            
            ButtonLarge(label: "Add Manually", action: {
                withAnimation() {
                    trackBottomSheetActive = false
                    detailsViewSelected = 6
                    sheetActive = true
                }
            })
            .frame(height: buttonHeight)
            .padding(.vertical, 2)
        }
        .padding(.horizontal, 16)
    }
}

struct BottomSheet: View {

    @Binding var isShowing: Bool
    var content: AnyView
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if (isShowing) {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                content
                    .padding(.bottom, 42)
                    .transition(.move(edge: .bottom))
                    .background(
                        Color(uiColor: .white)
                    )
                    .cornerRadius(16, corners: [.topLeft, .topRight])
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
}

struct ButtonLarge: View {
    
    var label: String
    var background: Color = .white
    var textColor: Color = .black.opacity(0.9)
    var action: (() -> ())
    
    let cornorRadius: CGFloat = 8
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(label)
                    .foregroundColor(textColor)
                    .font(.system(size: 16, weight: .bold))
                    .lineLimit(1)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: cornorRadius)
                    .stroke(.gray.opacity(0.5), lineWidth: 1)
            )
        }
        .background(background)
        .cornerRadius(cornorRadius)
    }
}

//
//  FlashlightButtonView.swift
//  Barcode
//
//  Created by Osman Balci on 2/11/24.
//  Copyright © 2024 Osman Balci. All rights reserved.
//

import SwiftUI

struct FlashlightButtonView: View {
    
    // Input parameter passed by reference
    @Binding var lightOn: Bool
    
    @Binding var detailsViewSelected: Int
    @Binding var sheetActive: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()    // Spaces to show the button on the right of the screen
                
                Button {
                    withAnimation() {
                        detailsViewSelected = 0
                        sheetActive = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(.white)
                }
                
                FlashlightButton(lightOn: $lightOn)
                    .padding()
            }
            Spacer()        // Spaces to show the button on the top of the screen
        }
        // Using Spacer(), the button is positioned on the top right corner of the screen
    }
}

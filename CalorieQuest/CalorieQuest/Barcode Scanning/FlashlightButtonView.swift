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
    
    var body: some View {
        VStack {
            HStack {
                Spacer()    // Spaces to show the button on the right of the screen
                FlashlightButton(lightOn: $lightOn)
                    .padding()
            }
            Spacer()        // Spaces to show the button on the top of the screen
        }
        // Using Spacer(), the button is positioned on the top right corner of the screen
    }
}


#Preview {
    FlashlightButtonView(lightOn: .constant(false))
}

//
//  FlashlightButton.swift
//  Barcode
//
//  Created by Osman Balci on 2/11/24.
//  Copyright © 2024 Osman Balci. All rights reserved.
//

import SwiftUI
import AVFoundation

struct FlashlightButton: View {

    // Input parameter passed by reference
    @Binding var lightOn: Bool
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                toggleLight()
            }
        }) {
            Image(systemName: (lightOn ? "bolt.fill" : "bolt"))
                .imageScale(.medium)
                .font(Font.title.weight(.regular))
                .foregroundColor(lightOn ? .yellow: .blue)
                .scaleEffect(lightOn ? 1.2 : 1.0)
                .rotationEffect(.degrees(lightOn ? 360: 0))
        }
    }
    
    func toggleLight() {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        lightOn.toggle()
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                device.torchMode = (lightOn) ? .on : .off
                device.unlockForConfiguration()
            } catch {
                print("Unable to Activate Flashlight!")
            }
        } else {
            print("Flashlight is Unavailable!")
        }
    }
}

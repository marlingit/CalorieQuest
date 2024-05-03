//
//  ScanQRBarcode.swift
//  Barcode
//
//  Created by Group 11: Vijay Vadi, Brighton Young, and Marlin Spears.
//  Copyright © 2024 Vijay, Brighton, and Marlin. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ScanQRBarcode: View {
    
    @Binding var detailsViewSelected: Int
    @Binding var sheetActive: Bool
    
    @State var barcode = ""
    @State var lightOn = false
    
    var body: some View {
        VStack {
            // Show barcode scanning camera view if no barcode is present
            if barcode.isEmpty {
                /*
                 Display barcode scanning camera view on the background layer because
                 we will display the results on the foreground layer in the same view.
                 */
                ZStack {
                    /*
                     BarcodeScanner displays the barcode scanning camera view, obtains the barcode
                     value, and stores it into the @State variable 'barcode'. When the @State value
                     changes,the view invalidates its appearance and recomputes this body view.
                     
                     When this body view is recomputed, 'barcode' will not be empty and the
                     else part of the if statement will be executed, which displays barcode
                     processing results on the foreground layer in this same view.
                     */
                    BarcodeScanner(code: $barcode)
                    
                    // Display the flashlight button view
                    FlashlightButtonView(lightOn: $lightOn, detailsViewSelected: $detailsViewSelected, sheetActive: $sheetActive)
                    
                    /*
                     Display the scan focus region image to guide the user during scanning.
                     The image is constructed in ScanFocusRegion.swift upon app launch.
                     */
                    scanFocusRegionImage
                }
            } else {
                // Show QR barcode processing results
                qrBarcodeProcessingResults
            }
        }   // End of VStack
            .onDisappear() {
                lightOn = false
        }
    }
    
    var qrBarcodeProcessingResults: some View {
        
        getNutritionDataFromUPC(upc: barcode)
        
        if foodItem.name.isEmpty {
            return AnyView(
                NotFound(message: "No Nutrition Data Returned!\n\nThe Nutritionix API did not return data for the item with UPC \(barcode)!")
            )
        }
        
        return AnyView(EmptyView())
        
    }
}

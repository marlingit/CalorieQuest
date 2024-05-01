//
//  ContentView.swift
//  CalorieQuest
//
//  Created by Marlin on 4/25/24.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        Button("Test") {
            getNutritionDataFromName(name: "hamburger")
        }
        .buttonStyle(.bordered)
    }
}

#Preview {
    ContentView()
}

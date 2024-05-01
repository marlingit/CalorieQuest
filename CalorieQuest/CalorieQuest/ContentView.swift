//
//  ContentView.swift
//  CalorieQuest
//
//  Created by Marlin on 4/25/24.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        let food = FoodStruct(name: "hamburger", itemId: /*"629df8f3dcb0f60009b64444"*/ "608", imageUrl: "", servingSize: 0.0, servingUnit: "", nutrients: [NutrientStruct]())
        let letters = CharacterSet.letters
        Button("Test") {
            getNutritionDataFromName(name: "hamburger")
            if let _ = food.itemId.rangeOfCharacter(from: letters) {
                print("letters")
                getNutritionDataForBranded(itemId: food.itemId)
            } else {
                getNutritionDataForCommon(name: food.name)
            }
            print(nutrientArray)
        }
        .buttonStyle(.bordered)
    }
}

#Preview {
    ContentView()
}

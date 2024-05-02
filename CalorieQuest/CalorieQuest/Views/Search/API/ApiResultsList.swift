//
//  ApiResultsList.swift
//  CalorieQuest
//
//  Created by Brighton Young on 5/2/24.
//  Copyright © 2024 Marlin Spears. All rights reserved.
//

import SwiftUI

struct ApiResultsList: View {
    var foodArray: [FoodStruct]
    
    var body: some View {
        List {
            ForEach(foodArray, id: \.itemId) { aFood in
                NavigationLink(destination: ApiResultsDetails(food: aFood)) {
                    ApiResultsItem(food: aFood)
                }
            }
        }
    }
}

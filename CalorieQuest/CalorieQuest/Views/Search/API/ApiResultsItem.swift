//
//  ApiResultsItem.swift
//  CalorieQuest
//
//  Created by Brighton Young on 5/2/24.
//  Copyright © 2024 Marlin Spears. All rights reserved.
//

import SwiftUI

struct ApiResultsItem: View {
    let food: FoodStruct
    var body: some View {
        Text(food.name)
    }
}

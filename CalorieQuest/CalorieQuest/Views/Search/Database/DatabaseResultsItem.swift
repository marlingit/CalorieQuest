//
//  DatabaseResultsItem.swift
//  CalorieQuest
//
//  Created by Brighton Young on 5/2/24.
//  Copyright © 2024 Marlin Spears. All rights reserved.
//

import SwiftUI

struct DatabaseResultsItem: View {
    let food: Food
    var body: some View {
        Text(food.name)
    }
}



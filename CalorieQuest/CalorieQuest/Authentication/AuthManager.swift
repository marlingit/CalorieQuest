//
//  AuthManager.swift
//  CalorieQuest
//
//  Created by Group 11: Vijay Vadi, Brighton Young, and Marlin Spears.
//  Copyright © 2024 Vijay, Brighton, and Marlin. All rights reserved.
//

import SwiftUI

struct AuthManager: View {
    
    @Namespace private var namespace
    @Binding var authenticationComplete: Bool
    
    var body: some View {
        if authenticationComplete {
            ContentView(namespace: namespace, authenticationComplete: $authenticationComplete) //
        } else {
            TestView(namespace: namespace, authenticationComplete: $authenticationComplete)
        }
    }
}

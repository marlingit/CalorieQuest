//
//  AuthManager.swift
//  CalorieQuest
//
//  Created by Vijay Vadi on 4/29/24.
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

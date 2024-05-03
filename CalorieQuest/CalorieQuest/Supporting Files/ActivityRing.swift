//
//  ActivityRing.swift
//  CalorieQuest
//
//  Created by Vijay Vadi on 4/30/24.
//

import SwiftUI

struct ActivityRingView: View {
    var progress: CGFloat

    @AppStorage("calorieTarget") var calorieTarget: String = "1"
    @AppStorage("caloriesCurrent") var caloriesCurrent: String = "0"
    
    @State var progressPercentage: CGFloat = 0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.25)
                .foregroundColor(Color.black)

            Circle()
                .trim(from: 0, to: progressPercentage)
                .stroke(
                    Color.black,
                    style: StrokeStyle(lineWidth: 10, lineCap: .round)
                )
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear, value: progressPercentage)
        }
        .onAppear(perform: calculatePercentage)
    }
    
    func calculatePercentage() {
        progressPercentage = CGFloat(Double(caloriesCurrent)! / Double(calorieTarget)!)
    }
}

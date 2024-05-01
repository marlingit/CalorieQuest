//
//  FavoriteItem.swift
//  CalorieQuest
//
//  Created by Vijay Vadi on 4/30/24.
//

import SwiftUI

struct FavoriteItem: View {
    var body: some View {
        HStack(spacing: 0) {
            Image("")
                .resizable()
                .frame(width: 100, height: 75)
                .mask(RoundedRectangle(cornerRadius: 12))
                .background(Color.black.opacity(0.25).mask(RoundedRectangle(cornerRadius: 12)))
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Item Name")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                Text("Item Description")
                    .font(.system(size: 15))
                    .fontWeight(.medium)
                    .padding(.top, 4)
            }.padding(.leading, 12)
            
            Spacer()
        }
    }
}

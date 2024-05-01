//
//  StarredView.swift
//  CalorieQuest
//
//  Created by Vijay Vadi on 4/30/24.
//

import SwiftUI

struct StarredView: View {
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 0) {
                
                Button {
                    
                } label: {
                    Image(systemName: "")
                        .resizable()
                        .scaledToFit()
                        .fontWeight(.heavy)
                        .foregroundStyle(.black)
                        .frame(width: 25)
                }
                .padding(.top, 4)
                
                Spacer()
                
                Text("Favorite")
                    .foregroundStyle(.black)
                    .font(.custom("Urbanist", size: 24))
                    .fontWeight(.heavy)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .fontWeight(.heavy)
                        .foregroundStyle(.black)
                        .frame(width: 25)
                }
                .padding(.top, 4)
            }.frame(maxWidth: .infinity)
                .padding(.leading, 24)
                .padding(.trailing, 24)
                .padding(.top, 12)
            ScrollView {
                ForEach(0..<4, id: \.self) { favorite in
                        FavoriteItem()
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.leading, 24)
                .padding(.trailing, 12)
        }
    }
}

struct FavoritesList: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<4, id: \.self) { favorite in
                        FavoriteItem()
                        .padding(.top, 4)
                }
                
            }   // End of List
            .font(.system(size: 14))
            .navigationTitle("List of Trips")
            .toolbarTitleDisplayMode(.inline)
            
        }   // End of NavigationStack
    }
}

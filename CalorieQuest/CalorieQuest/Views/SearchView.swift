//
//  SearchView.swift
//  CalorieQuest
//
//  Created by Vijay Vadi on 4/30/24.
//

import SwiftUI

struct SearchView: View {
    
    @State private var selectedOption: String = "Database"
    let options: [String] = ["Database", "API", "Videos"]
    
    @State private var searchQuery: String = ""
    
    var body: some View {
        VStack {
            
            HStack(alignment: .top, spacing: 0) {
                
                Spacer()
                
                Text("Search")
                    .foregroundStyle(.black)
                    .font(.custom("Urbanist", size: 24))
                    .fontWeight(.heavy)
                
                Spacer()
            }.frame(maxWidth: .infinity)
                .padding(.leading, 24)
                .padding(.trailing, 24)
                .padding(.top, 12)
            
            ScrollView {
                VStack(spacing: 0) {
                    Spacer()
                    Image("")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .mask(Circle())
                        .background(Color.black.opacity(0.25).mask(Circle()))
                    Picker("Choose an option", selection: $selectedOption) {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                                .font(.custom("Urbanist", size: 18))
                                .fontWeight(.bold)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.top, 24)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Search \(selectedOption)")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        TextField("Search", text: $searchQuery)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    
                    Button {
                        
                    } label: {
                        Text("Search")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color.black, in: RoundedRectangle(cornerRadius: 25))
                    }.padding(.top, 24)
                    
                    Spacer()
                    
                    Spacer()
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.leading, 24)
                .padding(.trailing, 24)
        }
    }
}

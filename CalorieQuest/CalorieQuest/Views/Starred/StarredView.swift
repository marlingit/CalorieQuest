//
//  StarredView.swift
//  CalorieQuest
//
//  Created by Vijay Vadi on 4/30/24.
//

import SwiftUI
import SwiftData

struct StarredView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(FetchDescriptor<Food>(sortBy: [SortDescriptor(\Food.name, order: .forward)])) private var listOfAllFoodsInDatabase: [Food]
    
    @State private var toBeDeleted: IndexSet?
    @State private var showConfirmation = false
    
    @Binding var detailsViewSelected: Int
    @Binding var sheetActive: Bool
    
    @State var isEditing = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 0) {
                
                Button {
                    self.isEditing.toggle()
                } label: {
                    Image(systemName: "trash")
                        .resizable()
                        .scaledToFit()
                        .fontWeight(.heavy)
                        .foregroundStyle(.black)
                        .frame(width: 25)
                }
                .padding(.top, 4)
                
                Spacer()
                
                Text("Favorite Foods")
                    .foregroundStyle(.black)
                    .font(.custom("Urbanist", size: 24))
                    .fontWeight(.heavy)
                
                Spacer()
                
                Button {
                    withAnimation() {
                        detailsViewSelected = 7
                        sheetActive = true
                    }
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
            NavigationStack {
                List {
                    ForEach(listOfAllFoodsInDatabase) { aFood in
                        if aFood.imageUrl != "" {
                            Button {
                                withAnimation() {
                                    detailsViewSelected = 8
                                    sheetActive = true
                                }
                                food = aFood
                            } label: {
                                FoodItem(food: aFood)
                                    .alert(isPresented: $showConfirmation) {
                                        Alert(title: Text("Delete Confirmation"),
                                              message: Text("Are you sure to permanently delete the food? It cannot be undone."),
                                              primaryButton: .destructive(Text("Delete")) {
                                            /*
                                             'toBeDeleted (IndexSet).first' is an unsafe pointer to the index number of the array
                                             element to be deleted. It is nil if the array is empty. Process it as an optional.
                                             */
                                            if let index = toBeDeleted?.first {
                                                
                                                let foodToDelete = listOfAllFoodsInDatabase[index]
                                                
                                                // ❎ Delete selected Trip object from the database
                                                modelContext.delete(foodToDelete)
                                            }
                                            toBeDeleted = nil
                                        }, secondaryButton: .cancel() {
                                            toBeDeleted = nil
                                        }
                                        )
                                    }   // End of alert
                            }
                            .foregroundStyle(.black)
                        }
                        
                    }
                    .onDelete(perform: delete)
                }
                .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.spring())
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.leading, 24)
                .padding(.trailing, 12)
        }
    }
    
    /*
     --------------------------
     MARK: Delete Selected Food
     --------------------------
     */
    func delete(at offsets: IndexSet) {
        
         toBeDeleted = offsets
         showConfirmation = true
     }
}


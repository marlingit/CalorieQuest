import SwiftUI

struct AddFavoriteFoodView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Binding var detailsViewSelected: Int
    @Binding var sheetActive: Bool
    
    @State var foodName: String = ""
    @State var calories: String = ""
    @State var fat: String = ""
    @State var carbohydrates: String = ""
    
    //------------------------------------
    // Image Picker from Camera or Library
    //------------------------------------
    @State private var showImagePicker = false
    @State private var pickedUIImage: UIImage?
    @State private var pickedImage: Image?
    
    @State private var useCamera = false
    @State private var usePhotoLibrary = true
    
    @State private var showAlertMessage = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 0) {
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
                
                Text("Add Food")
                    .foregroundStyle(.black)
                    .font(.custom("Urbanist", size: 24))
                    .fontWeight(.heavy)
                
                Spacer()
                
                Button {
                    detailsViewSelected = 0
                    sheetActive = false
                } label: {
                    Image(systemName: "xmark")
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
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Food Item Name")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        TextField("Item Name", text: $foodName)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Calorie Count")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        TextField("Calories", text: $calories)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Total Fat")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        TextField("Fat", text: $fat)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Total Carbohydrates")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        TextField("Carbohydrates", text: $carbohydrates)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color.black.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    
                    let camera = Binding(
                        get: { useCamera },
                        set: {
                            useCamera = $0
                            if $0 == true {
                                usePhotoLibrary = false
                            }
                        }
                    )
                    let photoLibrary = Binding(
                        get: { usePhotoLibrary },
                        set: {
                            usePhotoLibrary = $0
                            if $0 == true {
                                useCamera = false
                            }
                        }
                    )
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Item Picture")
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                        
                        VStack {
                            Toggle("Use Camera", isOn: camera)
                            Toggle("Use Photo Library", isOn: photoLibrary)
                            
                            Button("Get Photo") {
                                showImagePicker = true
                            }
                            .tint(.blue)
                            .buttonStyle(.bordered)
                            .buttonBorderShape(.capsule)
                        }
                        
                        if pickedImage != nil {
                            Section(header: Text("Taken or Picked Photo")) {
                                pickedImage?
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100.0, height: 100.0)
                            }
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            if isValidated() {
                                saveFavoriteFood()
                                
                                showAlertMessage = true
                                alertTitle = "New Favorite Food Saved!"
                                alertMessage = "Your new favorite food is successfully saved!"
                            } else {
                                showAlertMessage = true
                                alertTitle = "Incorrect Data!"
                                alertMessage = "Please ensure all fields are filled correctly!"
                            }
                        } label: {
                            Text("Add Food")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color.black, in: RoundedRectangle(cornerRadius: 25))
                        }
                        .alert(alertTitle, isPresented: $showAlertMessage, actions: {
                            Button("OK") {
                                if alertTitle == "New Favorite Food Saved!" {
                                    // Dismiss this view and go back to the previous view
                                    dismiss()
                                }
                            }
                        }, message: {
                            Text(alertMessage)
                        })
                        
                        Spacer()
                        
                    }.padding(.top, 48)
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 24)
                    .padding(.trailing, 24)
                    .padding(.top, 24)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 12)
            
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .onChange(of: pickedUIImage) {
                guard let uiImagePicked = pickedUIImage else { return }
                // Convert UIImage to SwiftUI Image
                pickedImage = Image(uiImage: uiImagePicked)
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(
                    uiImage: $pickedUIImage,
                    sourceType: useCamera ? .camera : .photoLibrary,
                    imageWidth: 500.0,
                    imageHeight: 281.25
                )
            }
    }
    
    func isValidated() -> Bool {
        if foodName.isEmpty || calories.isEmpty || fat.isEmpty || carbohydrates.isEmpty {
            return false
        }
        
        if Double(calories) == nil || Double(fat) == nil || Double(carbohydrates) == nil {
            return false
        }
        
        return true
    }
    
    func saveFavoriteFood() {
        //--------------------------------------------------
        // Store Taken or Picked Food Image to Document Directory
        //--------------------------------------------------
        var photoFullFilename = ""
        
        if let photoData = pickedUIImage {
            photoFullFilename = UUID().uuidString + ".jpg"
            if let jpegData = photoData.jpegData(compressionQuality: 1.0) {
                let fileUrl = documentDirectory.appendingPathComponent(photoFullFilename)
                try? jpegData.write(to: fileUrl)
            }
        }
        
        //-----------------------------------------------
        // Instantiate a new Food object and dress it up
        //-----------------------------------------------
        let newFood = Food(
            name: foodName,
            itemId: UUID().uuidString,
            imageUrl: photoFullFilename,
            servingSize: 0.0,
            servingUnit: ""
        )
        
        // Create and add nutrient objects to the food
        let caloriesNutrient = Nutrient(name: "calories", amount: Double(calories) ?? 0.0, unit: "kcal")
        let fatNutrient = Nutrient(name: "fat", amount: Double(fat) ?? 0.0, unit: "g")
        let carbohydratesNutrient = Nutrient(name: "carbohydrates", amount: Double(carbohydrates) ?? 0.0, unit: "g")
        
        newFood.nutrients = [caloriesNutrient, fatNutrient, carbohydratesNutrient]
        
        // Insert the new Food object into the database
        modelContext.insert(newFood)
        
        // Save the changes to the database
        do {
            try modelContext.save()
        } catch {
            print("Failed to save food: \(error)")
        }
        
        // Initialize @State variables
        showImagePicker = false
        pickedUIImage = nil
        foodName = ""
        calories = ""
        fat = ""
        carbohydrates = ""
    }
}

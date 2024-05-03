//
//  DatabaseCreation.swift
//  CalorieQuest
//
//  Created by Marlin on 4/30/24.
//

import SwiftData
import SwiftUI

public func createDatabase() {
    
    /*
     ------------------------------------------------
     |   Create Model Container and Model Context   |
     ------------------------------------------------
     */
    var modelContainer: ModelContainer

    do {
        // Create a database container to manage Day, Tracked, Food, Nutrient, and Video objects
        modelContainer = try ModelContainer(for: Day.self, Tracked.self, Food.self, Nutrient.self, Video.self)
    } catch {
        fatalError("Unable to create ModelContainer")
    }
    
    // Create the context (workspace) where database objects will be managed
    let modelContext = ModelContext(modelContainer)
    
    /*
     --------------------------------------------------------------------
     |   Check to see if the database has already been created or not   |
     --------------------------------------------------------------------
     */
    let foodFetchDescriptor = FetchDescriptor<Food>()
    
    var listOfAllFoodsInDatabase = [Food]()
    
    do {
        // Obtain all of the Food objects from the database
        listOfAllFoodsInDatabase = try modelContext.fetch(foodFetchDescriptor)
    } catch {
        fatalError("Unable to fetch Food objects from the database")
    }
    
    if !listOfAllFoodsInDatabase.isEmpty {
        print("Database has already been created!")
        return
    }
    
    print("Database will be created!")
    
    /*
     ----------------------------------------------------------
     | *** The app is being launched for the first time ***   |
     |   Database needs to be created and populated with      |
     |   the initial content in DatabaseInitialContent.json   |
     ----------------------------------------------------------
     */
    
    // Local variable arrayOfDayStructs obtained from the JSON file to populate the database
    var arrayOfDayStructs = [DayStruct]()
    
    arrayOfDayStructs = decodeJsonFileIntoArrayOfStructs(fullFilename: "FoodsData.json", fileLocation: "Main Bundle")
    
    for aDayStruct in arrayOfDayStructs {
        
        /*
         ===========================
         |   Day Object Creation   |
         ===========================
         */
        
        // Instantiate an empty Day object
        let newDay = Day(
            date: aDayStruct.date,
            
            tracked: [Tracked]()
        )
        
        // ❎ Insert it into the database context
        modelContext.insert(newDay)

        /*
         ===============================
         |   Tracked Object Creation   |
         ===============================
         */
        
        var listOfTrackedObjects = [Tracked]()

        for aTracked in aDayStruct.tracked {

            // Instantiate a Tracked object and dress it up
            let newTracked = Tracked(
                category: aTracked.category, 
                time: aTracked.time,
                
                foods: [Food]()
            )
            
            // ❎ Insert it into the database context
            modelContext.insert(newTracked)

            listOfTrackedObjects.append(newTracked)    // One Day can contain many Trackeds
            
            /*
             ============================
             |   Food Object Creation   |
             ============================
             */
            
            var listOfAllFoodObjects = [Food]()

            for aFood in aTracked.foods {
                
                let newFood = Food(
                    name: aFood.name,
                    itemId: aFood.itemId,
                    imageUrl: aFood.imageUrl,
                    servingSize: aFood.servingSize,
                    servingUnit: aFood.servingUnit,
                    nutrients: [Nutrient]()
                )
                
                modelContext.insert(newFood)
                
                listOfAllFoodObjects.append(newFood)
                
                /*
                 ================================
                 |   Nutrient Object Creation   |
                 ================================
                 */
                
                var listOfAllNutrientObjects = [Nutrient]()

                for aNutrient in aFood.nutrients {

                    // Instantiate a Nutrient object and dress it up
                    let newNutrient = Nutrient(
                        name: aNutrient.name,
                        amount: aNutrient.amount,
                        unit: aNutrient.unit,
                        
                        foods: [Food]()
                    )
                    
                    // ❎ Insert it into the database context
                    modelContext.insert(newNutrient)
                    
                    newNutrient.foods!.append(newFood)  // Many Nutrients can be in many Foods

                    listOfAllNutrientObjects.append(newNutrient)    // Many Foods can contain many Nutrients
                    
                }   // End of 'for aNutrient in aFood.nutrients' loop
                
                newFood.nutrients = listOfAllNutrientObjects
                
            }   // End of 'for aFood in aTracked.foods' loop
            
            newTracked.foods = listOfAllFoodObjects
            
        }   // End of 'for aTracked in aDayStruct.tracked' loop
        
        newDay.tracked = listOfTrackedObjects
        
    }   // End of 'for aDayStruct in arrayOfDayStructs' loop
    
    // Video Creation
    
    var arrayOfVideoStructs = [VideoStruct]()
    
    arrayOfVideoStructs = decodeJsonFileIntoArrayOfStructs(fullFilename: "VideosData.json", fileLocation: "Main Bundle")
    
    for aVideoStruct in arrayOfVideoStructs {
        
        let newVideo = Video(
            id: aVideoStruct.id,
            title: aVideoStruct.title,
            youtubeId: aVideoStruct.youtubeId,
            releaseDate: aVideoStruct.releaseDate,
            duration: aVideoStruct.duration
        )
        
        modelContext.insert(newVideo)
    }
    
    /*
     =================================
     |   Save All Database Changes   |
     =================================
     */
    do {
        try modelContext.save()
    } catch {
        fatalError("Unable to save database changes")
    }
    
    print("Database is successfully created!")
}

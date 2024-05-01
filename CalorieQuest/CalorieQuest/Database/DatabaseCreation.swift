//
//  DatabaseCreation.swift
//  CalorieQuest
//
//  Created by Marlin on 4/30/24.
//

import SwiftData
import SwiftUI

public func createDatabase() {
    
//    /*
//     ------------------------------------------------
//     |   Create Model Container and Model Context   |
//     ------------------------------------------------
//     */
//    var modelContainer: ModelContainer
//
//    do {
//        // Create a database container to manage Day, Tracked, Meal, Food, and Nutrient objects
//        modelContainer = try ModelContainer(for: Recipe.self, Cuisine.self, Publisher.self, Ingredient.self, Nutrient.self)
//    } catch {
//        fatalError("Unable to create ModelContainer")
//    }
//    
//    // Create the context (workspace) where database objects will be managed
//    let modelContext = ModelContext(modelContainer)
//    
//    /*
//     --------------------------------------------------------------------
//     |   Check to see if the database has already been created or not   |
//     --------------------------------------------------------------------
//     */
//    let recipeFetchDescriptor = FetchDescriptor<Cuisine>()
//    
//    var listOfAllCuisinesInDatabase = [Cuisine]()
//    
//    do {
//        // Obtain all of the Cuisine objects from the database
//        listOfAllCuisinesInDatabase = try modelContext.fetch(recipeFetchDescriptor)
//    } catch {
//        fatalError("Unable to fetch Cuisine objects from the database")
//    }
//    
//    if !listOfAllCuisinesInDatabase.isEmpty {
//        print("Database has already been created!")
//        return
//    }
//    
//    print("Database will be created!")
//    
//    /*
//     ----------------------------------------------------------
//     | *** The app is being launched for the first time ***   |
//     |   Database needs to be created and populated with      |
//     |   the initial content in DatabaseInitialContent.json   |
//     ----------------------------------------------------------
//     */
//    
//    // Local variable arrayOfRecipeStructs obtained from the JSON file to populate the database
//    var arrayOfRecipeStructs = [RecipeStruct]()
//    
//    arrayOfRecipeStructs = decodeJsonFileIntoArrayOfStructs(fullFilename: "DatabaseInitialContent.json", fileLocation: "Main Bundle")
//    
//    for aRecipeStruct in arrayOfRecipeStructs {
//        
//        /*
//         ==============================
//         |   Recipe Object Creation   |
//         ==============================
//         */
//        
//        // Instantiate an empty Recipe object
//        let newRecipe = Recipe(
//            // Attributes
//            name: aRecipeStruct.name,
//            category: aRecipeStruct.category,
//            photoUrl: aRecipeStruct.photoUrl,
//            websiteUrl: aRecipeStruct.websiteUrl,
//            
//            // Relationships
//            cuisine: Cuisine(name: "", recipes: [Recipe]()),
//            publisher: Publisher(name: "", websiteUrl: "", recipes: [Recipe]()),
//            ingredients: [Ingredient](),
//            nutrients: [Nutrient]()
//        )
//        
//        // ❎ Insert it into the database context
//        modelContext.insert(newRecipe)
//        
//        /*
//         ===============================
//         |   Cuisine Object Creation   |
//         ===============================
//         */
//
//        // 1️⃣ Define the Search Criterion (Predicate)
//        let cuisineName = aRecipeStruct.cuisine.name
//        let cuisinePredicate = #Predicate<Cuisine> {
//            $0.name == cuisineName
//        }
//        
//        // 2️⃣ Define the Fetch Descriptor
//        let cuisineFetchDescriptor = FetchDescriptor<Cuisine>(
//            predicate: cuisinePredicate,
//            sortBy: [SortDescriptor(\Cuisine.name, order: .forward)]
//        )
//        
//        var cuisineResultsArray: [Cuisine]
//        var aCuisine: Cuisine
//        
//        do {
//            // 3️⃣ Execute the Fetch Request
//            /*
//             Only one cuisine has the given unique aRecipeStruct.cuisine.name
//             However, the 'fetch' below always returns database search results in an array.
//             Therefore, results must be specified as an array even if only one can be found.
//             */
//            // Obtain all Cuisine objects satisfying the search criterion (Predicate)
//            cuisineResultsArray = try modelContext.fetch(cuisineFetchDescriptor)
//            
//            if cuisineResultsArray.isEmpty {
//                /*
//                 A cuisine with 'aRecipeStruct.cuisine.name' does not exist in the database.
//                 Create and insert it into the database.
//                 */
//                
//                // Instantiate a Cuisine object and dress it up
//                aCuisine = Cuisine(
//                    // Attribute
//                    name: aRecipeStruct.cuisine.name,
//                    
//                    // Relationship
//                    recipes: [Recipe]()
//                )
//                
//                // ❎ Insert it into the database context
//                modelContext.insert(aCuisine)
//
//            } else {
//                /*
//                 A cuisine with 'aRecipeStruct.cuisine.name' already exists in the database.
//                 Store the found Cuisine's object reference into aCuisine.
//                 */
//                aCuisine = cuisineResultsArray[0]
//            }
//        } catch {
//            fatalError("Unable to fetch Cuisine data from the database")
//        }
//
//        // Establish one-to-many relationship
//        newRecipe.cuisine = aCuisine            // A recipe can belong to only one cuisine
//        aCuisine.recipes!.append(newRecipe)     // A cuisine can have many recipes
//        
//        /*
//         =================================
//         |   Publisher Object Creation   |
//         =================================
//         */
//
//        // 1️⃣ Define the Search Criterion (Predicate)
//        let publisherName = aRecipeStruct.publisher.name
//        let publisherPredicate = #Predicate<Publisher> {
//            $0.name == publisherName
//        }
//        
//        // 2️⃣ Define the Fetch Descriptor
//        let publisherFetchDescriptor = FetchDescriptor<Publisher>(
//            predicate: publisherPredicate,
//            sortBy: [SortDescriptor(\Publisher.name, order: .forward)]
//        )
//        
//        var publisherResultsArray: [Publisher]
//        var aPublisher: Publisher
//        
//        do {
//            // 3️⃣ Execute the Fetch Request
//            /*
//             Only one publisher has the given unique aRecipeStruct.publisher.name
//             However, the 'fetch' below always returns database search results in an array.
//             Therefore, results must be specified as an array even if only one can be found.
//             */
//            
//            // Obtain all publisher objects satisfying the search criterion (Predicate)
//            publisherResultsArray = try modelContext.fetch(publisherFetchDescriptor)
//            
//            if publisherResultsArray.isEmpty {
//                
//                /*
//                 A publisher with 'aRecipeStruct.publisher.name' does not exist in the database.
//                 Create and insert it into the database.
//                 */
//
//                // Instantiate a Publisher object and dress it up
//                aPublisher = Publisher(
//                    // Attributes
//                    name: aRecipeStruct.publisher.name,
//                    websiteUrl: aRecipeStruct.publisher.websiteUrl,
//                    
//                    // Relationship
//                    recipes: [Recipe]()
//                )
//                
//                // ❎ Insert it into the database context
//                modelContext.insert(aPublisher)
//
//            } else {
//                /*
//                 A publisher with 'aRecipeStruct.publisher.name' already exists in the database.
//                 Store the found Publisher's object reference into aPublisher.
//                 */
//                aPublisher = publisherResultsArray[0]
//            }
//        } catch {
//            fatalError("Unable to fetch Publisher data from the database")
//        }
//
//        // Establish one-to-many relationship
//        newRecipe.publisher = aPublisher        // A recipe can have only one publisher
//        aPublisher.recipes!.append(newRecipe)   // A publisher can have many recipes
//        
//        /*
//         ==================================
//         |   Ingredient Object Creation   |
//         ==================================
//         */
//
//        for anIngredient in aRecipeStruct.ingredients {
//
//            // Instantiate an Ingredient object and dress it up
//            let newIngredient = Ingredient(
//                // Attributes
//                amount: anIngredient.amount,
//                unit: anIngredient.unit,
//                name: anIngredient.name,
//                
//                // Relationship
//                recipes: [Recipe]()
//            )
//            
//            // ❎ Insert it into the database context
//            modelContext.insert(newIngredient)
//
//            // Establish many-to-many relationship
//            newIngredient.recipes!.append(newRecipe)        // Many Ingredients can be in many Recipes
//            newRecipe.ingredients!.append(newIngredient)    // Many Recipes can contain many Ingredients
//            
//        }   // End of 'for anIngredient in aRecipeStruct.ingredients' loop
//
//        /*
//         ================================
//         |   Nutrient Object Creation   |
//         ================================
//         */
//        
//        for aNutrient in aRecipeStruct.nutrients {
//            
//            // Instantiate a Nutrient object and dress it up
//            let newNutrient = Nutrient(
//                // Attributes
//                name: aNutrient.name,
//                amount: aNutrient.amount,
//                unit: aNutrient.unit,
//                
//                // Relationship
//                recipes: [Recipe]()
//            )
//            
//            // ❎ Insert it into the database context
//            modelContext.insert(newNutrient)
//            
//            // Establish many-to-many relationship
//            newNutrient.recipes!.append(newRecipe)      // Many Nutrients can be in many Recipes
//            newRecipe.nutrients!.append(newNutrient)    // Many Recipes can contain many Nutrients
//            
//        }   // End of 'for aNutrient in aRecipeStruct.nutrients' loop
//        
//    }   // End of 'for aRecipeStruct in arrayOfRecipeStructs' loop
//    
//    /*
//     =================================
//     |   Save All Database Changes   |
//     =================================
//     */
//    do {
//        try modelContext.save()
//    } catch {
//        fatalError("Unable to save database changes")
//    }
//    
//    print("Database is successfully created!")
}

//
//  NutritionixApiData.swift
//  Barcode
//
//  Created by Group 11: Vijay Vadi, Brighton Young, and Marlin Spears.
//  Copyright © 2024 Vijay, Brighton, and Marlin. All rights reserved.
//

import Foundation

fileprivate let appID  = "48aac022"
fileprivate let appKey = "04a63c0b6935fe6acce5d2ab330b4e1d"

var foodItem = FoodStruct(name: "", itemId: "", imageUrl: "", servingSize: 0, servingUnit: "", nutrients: [])

fileprivate var previousUPC = ""

public func getNutritionDataFromUPC(upc: String) {
    // Check if the UPC has already been processed
    if upc == previousUPC {
        return
    } else {
        previousUPC = upc
    }
    
    // Reset the foodItem to an empty instance
    foodItem = FoodStruct(name: "", itemId: "", imageUrl: "", servingSize: 0, servingUnit: "", nutrients: [])
    
    // Construct the API query URL
    var apiQueryUrlStruct: URL?
    if let urlStruct = URL(string: "https://trackapi.nutritionix.com/v2/search/item?upc=\(upc)") {
        apiQueryUrlStruct = urlStruct
    } else {
        return
    }
    
    // Set up the HTTP headers
    let headers = [
        "x-app-id": appID,
        "x-app-key": appKey,
        "accept": "application/json",
        "cache-control": "no-cache",
        "host": "trackapi.nutritionix.com"
    ]
    
    // Create the API request
    let request = NSMutableURLRequest(url: apiQueryUrlStruct!,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    // Create a semaphore for synchronization
    let semaphore = DispatchSemaphore(value: 0)
    
    // Send the API request asynchronously
    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        // Check for errors
        guard error == nil else {
            semaphore.signal()
            return
        }
        
        // Check for a successful HTTP response
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            semaphore.signal()
            return
        }
        
        // Check if data is available
        guard let jsonDataFromApi = data else {
            semaphore.signal()
            return
        }
        
        // Parse the JSON data
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi,
                                                                options: JSONSerialization.ReadingOptions.mutableContainers)
            
            var jsonDataDictionary = Dictionary<String, Any>()
            if let jsonObject = jsonResponse as? [String: Any] {
                jsonDataDictionary = jsonObject
            } else {
                semaphore.signal()
                return
            }
            
            // Extract the foods array from the JSON
            var foodsJsonArray = [Any]()
            if let jArray = jsonDataDictionary["foods"] as? [Any] {
                foodsJsonArray = jArray
            } else {
                semaphore.signal()
                return
            }
            
            // Extract the first food item from the array
            var foodsJsonObject = [String: Any]()
            if let jObject = foodsJsonArray[0] as? [String: Any] {
                foodsJsonObject = jObject
            } else {
                semaphore.signal()
                return
            }
            
            // Extract the food name
            var food_name = ""
            if let nameOfFood = foodsJsonObject["food_name"] as? String {
                food_name = nameOfFood
            } else {
                semaphore.signal()
                return
            }
            
            // Extract item id
            var food_id = ""
            if let itemId = foodsJsonObject["nix_brand_id"] as? String {
                food_id = itemId
            } else {
                semaphore.signal()
                return
            }
            
            // Extract the photo URL
            var photo_url = ""
            if let photoJsonObject = foodsJsonObject["photo"] as? [String: Any],
               let thumbUrl = photoJsonObject["thumb"] as? String {
                photo_url = thumbUrl
            }
            
            // Extract the nutrients
            var nutrients: [NutrientStruct] = []
            
            if let caloriesAmount = foodsJsonObject["nf_calories"] as? Double {
                let caloriesNutrient = NutrientStruct(name: "Calories", amount: caloriesAmount, unit: "kcal")
                nutrients.append(caloriesNutrient)
            }
            
            if let totalFat = foodsJsonObject["nf_total_fat"] as? Double {
                let fatNutrient = NutrientStruct(name: "Total Fat", amount: totalFat, unit: "grams")
                nutrients.append(fatNutrient)
            }
            
            if let saturatedFat = foodsJsonObject["nf_saturated_fat"] as? Double {
                let saturatedFatNutrient = NutrientStruct(name: "Saturated Fat", amount: saturatedFat, unit: "grams")
                nutrients.append(saturatedFatNutrient)
            }
            
            if let cholesterol = foodsJsonObject["nf_cholesterol"] as? Double {
                let cholesterolNutrient = NutrientStruct(name: "Cholesterol", amount: cholesterol, unit: "milligrams")
                nutrients.append(cholesterolNutrient)
            }
            
            if let sodium = foodsJsonObject["nf_sodium"] as? Double {
                let sodiumNutrient = NutrientStruct(name: "Sodium", amount: sodium, unit: "milligrams")
                nutrients.append(sodiumNutrient)
            }
            
            if let totalCarbohydrate = foodsJsonObject["nf_total_carbohydrate"] as? Double {
                let carbNutrient = NutrientStruct(name: "Total Carbohydrate", amount: totalCarbohydrate, unit: "grams")
                nutrients.append(carbNutrient)
            }
            
            if let dietaryFiber = foodsJsonObject["nf_dietary_fiber"] as? Double {
                let fiberNutrient = NutrientStruct(name: "Dietary Fiber", amount: dietaryFiber, unit: "grams")
                nutrients.append(fiberNutrient)
            }
            
            if let sugars = foodsJsonObject["nf_sugars"] as? Double {
                let sugarsNutrient = NutrientStruct(name: "Sugars", amount: sugars, unit: "grams")
                nutrients.append(sugarsNutrient)
            }
            
            if let protein = foodsJsonObject["nf_protein"] as? Double {
                let proteinNutrient = NutrientStruct(name: "Protein", amount: protein, unit: "grams")
                nutrients.append(proteinNutrient)
            }
            
            if let potassium = foodsJsonObject["nf_potassium"] as? Double {
                let potassiumNutrient = NutrientStruct(name: "Potassium", amount: potassium, unit: "milligrams")
                nutrients.append(potassiumNutrient)
            }
            
            // Extract the serving size and unit
            var servingSize = 0.0
            if let serving_qty = foodsJsonObject["serving_qty"] as? Double {
                servingSize = serving_qty
            }
            
            var servingUnit = ""
            if let unitOfServing = foodsJsonObject["serving_unit"] as? String {
                servingUnit = unitOfServing
            }
            
            // Create the foodItem instance with the extracted data
            foodItem = FoodStruct(name: food_name, itemId: food_id, imageUrl: photo_url, servingSize: servingSize, servingUnit: servingUnit, nutrients: nutrients)
            
            print(foodItem)
            
        } catch {
            semaphore.signal()
            return
        }
        
        semaphore.signal()
    }).resume()
    
    // Wait for the API request to complete
    _ = semaphore.wait(timeout: .now() + 10)
}

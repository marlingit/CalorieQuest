//
//  NutritionixDataFromName.swift
//  CalorieQuest
//
//  Created by Brighton Young on 5/1/24 and Osman Balci.
//  Copyright © 2024 Marlin Spears. All rights reserved.
//

import Foundation

fileprivate let appID  = "48aac022"
fileprivate let appKey = "04a63c0b6935fe6acce5d2ab330b4e1d"

var foodArray = [FoodStruct]()

fileprivate var previousName = ""

public func getNutritionDataFromName(name: String) {
    // Check if the name has already been processed
    if name == previousName {
        return
    } else {
        previousName = name
    }
    
    // Reset the foodItem to an empty instance
    foodArray = [FoodStruct]()
    
    // Construct the API query URL
    var apiQueryUrlStruct: URL?
    if let urlStruct = URL(string: "https://trackapi.nutritionix.com/v2/search/instant?query=\(name)") {
        apiQueryUrlStruct = urlStruct
    } else {
        return
    }
    
    // Set up the HTTP headers
    let headers = [
        "Content-Type": "application/json",
        "x-app-id": appID,
        "x-app-key": appKey
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
            print(jsonDataDictionary)
            
            // Extract the common foods array from the JSON
            var commonFoodsJsonArray = [Any]()
            if let jArray = jsonDataDictionary["common"] as? [Any] {
                commonFoodsJsonArray = jArray
            } else {
                semaphore.signal()
                return
            }
            
            for aFoodItem in commonFoodsJsonArray {
                
                // Extract the first food item from the array
                var foodsJsonObject = [String: Any]()
                if let jObject = aFoodItem as? [String: Any] {
                    foodsJsonObject = jObject
                } else {
                    semaphore.signal()
                    return
                }
                
                // First check item id
                var food_id = ""
                if let itemId = foodsJsonObject["tag_id"] as? String {
                    if foodArray.contains(where: {$0.itemId == itemId}) {
                        continue
                    }
                    food_id = itemId
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
                
                // Extract the photo URL
                var photo_url = ""
                if let photoJsonObject = foodsJsonObject["photo"] as? [String: Any],
                   let thumbUrl = photoJsonObject["thumb"] as? String {
                    photo_url = thumbUrl
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
                var nutrients = [NutrientStruct]()
                
                nutrients = getNutritionDataForCommon(name: food_name)
                
                let foodItem = FoodStruct(name: food_name, itemId: food_id, imageUrl: photo_url, servingSize: servingSize, servingUnit: servingUnit, nutrients: nutrients)
                
                foodArray.append(foodItem)
                
            }
            
            // Extract the branded foods array from the JSON
            var brandedFoodsJsonArray = [Any]()
            if let jArray = jsonDataDictionary["branded"] as? [Any] {
                brandedFoodsJsonArray = jArray
            } else {
                semaphore.signal()
                return
            }
            
            for aFoodItem in brandedFoodsJsonArray {
                
                // Extract the first food item from the array
                var foodsJsonObject = [String: Any]()
                if let jObject = aFoodItem as? [String: Any] {
                    foodsJsonObject = jObject
                } else {
                    semaphore.signal()
                    return
                }
                
                // First check item id
                var food_id = ""
                if let itemId = foodsJsonObject["nix_item_id"] as? String {
                    if foodArray.contains(where: {$0.itemId == itemId}) {
                        continue
                    }
                    food_id = itemId
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
                
                // Extract the photo URL
                var photo_url = ""
                if let photoJsonObject = foodsJsonObject["photo"] as? [String: Any],
                   let thumbUrl = photoJsonObject["thumb"] as? String {
                    photo_url = thumbUrl
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
                
                var nutrients = [NutrientStruct]()
                
                nutrients = getNutritionDataForBranded(itemId: food_id)
                
                // Create the foodItem instance with the extracted data
                let foodItem = FoodStruct(name: food_name, itemId: food_id, imageUrl: photo_url, servingSize: servingSize, servingUnit: servingUnit, nutrients: nutrients)
                
                foodArray.append(foodItem)
            }
            
        } catch {
            semaphore.signal()
            return
        }
        
        semaphore.signal()
    }).resume()
    
    // Wait for the API request to complete
    _ = semaphore.wait(timeout: .now() + 100)
    
    print(foodArray)
}

private func getNutritionDataForCommon(name: String) -> [NutrientStruct] {
    
    
    var nutrients = [NutrientStruct]()
    
    // Construct the API query URL
    var apiQueryUrlStruct: URL?
    if let urlStruct = URL(string: "https://trackapi.nutritionix.com/v2/natural/nutrients?query=\(name)") {
        apiQueryUrlStruct = urlStruct
    } else {
        return nutrients
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
            
        } catch {
            semaphore.signal()
            return
        }
        
        semaphore.signal()
    }).resume()
    
    // Wait for the API request to complete
    _ = semaphore.wait(timeout: .now() + 10)
    
    return nutrients
}

private func getNutritionDataForBranded(itemId: String) -> [NutrientStruct] {
    
    
    var nutrients = [NutrientStruct]()
    
    // Construct the API query URL
    var apiQueryUrlStruct: URL?
    if let urlStruct = URL(string: "https://trackapi.nutritionix.com/v2/search/item?nix_item_id=\(itemId)") {
        apiQueryUrlStruct = urlStruct
    } else {
        return nutrients
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
            
        } catch {
            semaphore.signal()
            return
        }
        
        semaphore.signal()
    }).resume()
    
    // Wait for the API request to complete
    _ = semaphore.wait(timeout: .now() + 10)
    
    return nutrients
}


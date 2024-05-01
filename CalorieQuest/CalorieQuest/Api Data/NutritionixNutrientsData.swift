//
//  NutritionixNutrientsData.swift
//  CalorieQuest
//
//  Created by Marlin on 5/1/24.
//  Copyright © 2024 Marlin Spears. All rights reserved.
//

import Foundation

fileprivate let appID  = "baa4227f"
fileprivate let appKey = "6d2f6e938c94053e0c55664ecdb245c6"

var nutrientArray = [NutrientStruct]()

fileprivate var previousQuery = ""

public func getNutritionDataForCommon(name: String) {
    
    // Check if the name has already been processed
    if name == previousQuery {
        return
    } else {
        previousQuery = name
    }
    
    nutrientArray = [NutrientStruct]()
    
    // Construct the API query URL
    var apiQueryUrlStruct: URL?
    if let urlStruct = URL(string: "https://trackapi.nutritionix.com/v2/natural/nutrients") {
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
    
    let jsonBody: [String: Any] = ["query": name]
    let jData = try? JSONSerialization.data(withJSONObject: jsonBody)
    
    // Create the API request
    let request = NSMutableURLRequest(url: apiQueryUrlStruct!,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headers
    request.httpBody = jData
    
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
                nutrientArray.append(caloriesNutrient)
            }
            
            if let totalFat = foodsJsonObject["nf_total_fat"] as? Double {
                let fatNutrient = NutrientStruct(name: "Total Fat", amount: totalFat, unit: "grams")
                nutrientArray.append(fatNutrient)
            }
            
            if let saturatedFat = foodsJsonObject["nf_saturated_fat"] as? Double {
                let saturatedFatNutrient = NutrientStruct(name: "Saturated Fat", amount: saturatedFat, unit: "grams")
                nutrientArray.append(saturatedFatNutrient)
            }
            
            if let cholesterol = foodsJsonObject["nf_cholesterol"] as? Double {
                let cholesterolNutrient = NutrientStruct(name: "Cholesterol", amount: cholesterol, unit: "milligrams")
                nutrientArray.append(cholesterolNutrient)
            }
            
            if let sodium = foodsJsonObject["nf_sodium"] as? Double {
                let sodiumNutrient = NutrientStruct(name: "Sodium", amount: sodium, unit: "milligrams")
                nutrientArray.append(sodiumNutrient)
            }
            
            if let totalCarbohydrate = foodsJsonObject["nf_total_carbohydrate"] as? Double {
                let carbNutrient = NutrientStruct(name: "Total Carbohydrate", amount: totalCarbohydrate, unit: "grams")
                nutrientArray.append(carbNutrient)
            }
            
            if let dietaryFiber = foodsJsonObject["nf_dietary_fiber"] as? Double {
                let fiberNutrient = NutrientStruct(name: "Dietary Fiber", amount: dietaryFiber, unit: "grams")
                nutrientArray.append(fiberNutrient)
            }
            
            if let sugars = foodsJsonObject["nf_sugars"] as? Double {
                let sugarsNutrient = NutrientStruct(name: "Sugars", amount: sugars, unit: "grams")
                nutrientArray.append(sugarsNutrient)
            }
            
            if let protein = foodsJsonObject["nf_protein"] as? Double {
                let proteinNutrient = NutrientStruct(name: "Protein", amount: protein, unit: "grams")
                nutrientArray.append(proteinNutrient)
            }
            
            if let potassium = foodsJsonObject["nf_potassium"] as? Double {
                let potassiumNutrient = NutrientStruct(name: "Potassium", amount: potassium, unit: "milligrams")
                nutrientArray.append(potassiumNutrient)
            }
            
        } catch {
            semaphore.signal()
            print("catch")
            return
        }
        
        semaphore.signal()
    }).resume()
    
    // Wait for the API request to complete
    _ = semaphore.wait(timeout: .now() + 10)
    
    return
}

public func getNutritionDataForBranded(itemId: String) {
    // Check if the name has already been processed
    if itemId == previousQuery {
        return
    } else {
        previousQuery = itemId
    }
    
    nutrientArray = [NutrientStruct]()
    
    // Construct the API query URL
    var apiQueryUrlStruct: URL?
    if let urlStruct = URL(string: "https://trackapi.nutritionix.com/v2/search/item?nix_item_id=\(itemId)") {
        apiQueryUrlStruct = urlStruct
    } else {
        return
    }
    
    // Set up the HTTP headers
    let headers = [
        "Content-Type": "application/x-www-form-urlencoded",
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
                nutrientArray.append(caloriesNutrient)
            }
            
            if let totalFat = foodsJsonObject["nf_total_fat"] as? Double {
                let fatNutrient = NutrientStruct(name: "Total Fat", amount: totalFat, unit: "grams")
                nutrientArray.append(fatNutrient)
            }
            
            if let saturatedFat = foodsJsonObject["nf_saturated_fat"] as? Double {
                let saturatedFatNutrient = NutrientStruct(name: "Saturated Fat", amount: saturatedFat, unit: "grams")
                nutrientArray.append(saturatedFatNutrient)
            }
            
            if let cholesterol = foodsJsonObject["nf_cholesterol"] as? Double {
                let cholesterolNutrient = NutrientStruct(name: "Cholesterol", amount: cholesterol, unit: "milligrams")
                nutrientArray.append(cholesterolNutrient)
            }
            
            if let sodium = foodsJsonObject["nf_sodium"] as? Double {
                let sodiumNutrient = NutrientStruct(name: "Sodium", amount: sodium, unit: "milligrams")
                nutrientArray.append(sodiumNutrient)
            }
            
            if let totalCarbohydrate = foodsJsonObject["nf_total_carbohydrate"] as? Double {
                let carbNutrient = NutrientStruct(name: "Total Carbohydrate", amount: totalCarbohydrate, unit: "grams")
                nutrientArray.append(carbNutrient)
            }
            
            if let dietaryFiber = foodsJsonObject["nf_dietary_fiber"] as? Double {
                let fiberNutrient = NutrientStruct(name: "Dietary Fiber", amount: dietaryFiber, unit: "grams")
                nutrientArray.append(fiberNutrient)
            }
            
            if let sugars = foodsJsonObject["nf_sugars"] as? Double {
                let sugarsNutrient = NutrientStruct(name: "Sugars", amount: sugars, unit: "grams")
                nutrientArray.append(sugarsNutrient)
            }
            
            if let protein = foodsJsonObject["nf_protein"] as? Double {
                let proteinNutrient = NutrientStruct(name: "Protein", amount: protein, unit: "grams")
                nutrientArray.append(proteinNutrient)
            }
            
            if let potassium = foodsJsonObject["nf_potassium"] as? Double {
                let potassiumNutrient = NutrientStruct(name: "Potassium", amount: potassium, unit: "milligrams")
                nutrientArray.append(potassiumNutrient)
            }
            
        } catch {
            semaphore.signal()
            return
        }
        
        semaphore.signal()
    }).resume()
    
    // Wait for the API request to complete
    _ = semaphore.wait(timeout: .now() + 10)
    
    return
}



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

fileprivate var foodItem = FoodStruct(name: "", imageUrl: "", servingSize: 0, servingUnit: "", nutrients: [])

fileprivate var previousName = ""

public func getNutritionDataFromName(name: String) {
    // Check if the name has already been processed
    if name == previousName {
        return
    } else {
        previousName = name
    }
    
    // Reset the foodItem to an empty instance
    foodItem = FoodStruct(name: "", imageUrl: "", servingSize: 0, servingUnit: "", nutrients: [])
    
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
            
            // Extract the common foods array from the JSON
            var commonFoodsJsonArray = [Any]()
            if let jArray = jsonDataDictionary["common"] as? [Any] {
                commonFoodsJsonArray = jArray
            } else {
                semaphore.signal()
                return
            }
            
            // Extract the first food item from the array
            var foodsJsonObject = [String: Any]()
            if let jObject = commonFoodsJsonArray[0] as? [String: Any] {
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
            foodItem = FoodStruct(name: food_name, imageUrl: photo_url, servingSize: servingSize, servingUnit: servingUnit, nutrients: [])
            
        } catch {
            semaphore.signal()
            return
        }
        
        semaphore.signal()
    }).resume()
    
    // Wait for the API request to complete
    _ = semaphore.wait(timeout: .now() + 10)
}

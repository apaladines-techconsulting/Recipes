//
//  MealsFilterResponse.swift
//  RecipesApp
//
//  Created by Consultant on 8/15/23.
//
// https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood
// Used in the main list of meals

import Foundation

// MARK: - MealsResponse
struct MealsFilterResponse: Codable {
    let meals: [MealPreview]
}

// MARK: - Meal
struct MealPreview: Codable, Identifiable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String

    var id: Int {
        guard let newId = Int(strMeal) else {
            return Date().timeInterValInteger
        }
        return newId
    }
}
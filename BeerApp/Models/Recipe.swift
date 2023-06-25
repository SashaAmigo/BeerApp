//
//  Recipe.swift
//  BeerApp
//
//  Created by Саша Amigo on 22.06.2023.
//

import Foundation

struct Recipe: Decodable {
    let name: String
    let imageUrl: String
    let description: String
    let tagLine: String
    let abv: Double
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case imageUrl = "image_url"
        case description = "description"
        case tagLine = "tagline"
        case abv = "abv"
    }
    
    init(recipeData: [String: Any]) {
        name = recipeData["name"] as? String ?? ""
        imageUrl = recipeData["image_url"] as? String ?? ""
        description = recipeData["description"] as? String ?? ""
        tagLine =  recipeData["tagline"] as? String ?? ""
        abv = recipeData["abv"] as? Double ?? 0.0
    }
    
    static func getRecipes(from value: Any) -> [Recipe] {
        guard let recipesData = value as? [[String: Any]] else { return [] }
        return recipesData.map { Recipe(recipeData: $0)}
        
    }
}

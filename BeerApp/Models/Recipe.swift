//
//  Recipe.swift
//  BeerApp
//
//  Created by Саша Amigo on 22.06.2023.
//

import Foundation

struct Recipe: Decodable {
    let name: String?
    let imageUrl: String?
    let description: String?
    let tagLine: String?
    let abv: Double?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case imageUrl = "image_url"
        case description = "description"
        case tagLine = "tagline"
        case abv = "abv"
    }
}

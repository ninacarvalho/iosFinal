//
//  DrinkDetails.swift
//  finalProject
//
//  Created by Marina Carvalho on 2024-12-13.
//

struct DrinkDetailResponse: Codable {
    let drinks: [DrinkDetail]
}

struct DrinkDetail: Codable {
    let strDrink: String
    let strCategory: String
    let strAlcoholic: String
    let strInstructions: String?
    let strInstructionsES: String?
    let strInstructionsDE: String?
    let strDrinkThumb: String
}

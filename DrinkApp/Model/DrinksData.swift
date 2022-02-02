//
//  DrinksData.swift
//  DrinkApp
//
//  Created by Mario Saldana on 31/01/22.
//

import Foundation

struct DrinkDataModel: Decodable {
    let idDrink: String
    let strDrink: String
    let strCategory: String?
    let strGlass: String?
    let strInstructions: String?
    let strDrinkThumb: String?
    let strIngredient1: String?
    let strMeasure1: String?
}


struct DrinksDataModel: Decodable {
    let drinks: [DrinkDataModel]
}

//
//  IngredientResponse.swift
//  DrinkIt
//
//  Created by Santi Nieves on 15/7/25.
//

import SwiftUI

struct IngredientResponse: Response, Codable {
    var errors: [ErrorResponse]?
    let ingredients: [Ingredient]?
}

struct Ingredient: Codable {
    let idIngredient: String?
    let strIngredient: String?
    let strDescription: String?
    let strType: String?
    let strAlcohol: String?
    let strABV: String?
}

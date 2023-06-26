//
//  Model.swift
//  RecipesApp
//
//  Created by Mobile on 25/06/2023.
//

import Foundation

class Model {
    var phoneNumber: String?
    var name: String?
    var personalEmail: String?
    var workEmail: String?
    var index: Int = 0
    var recipe: Recipe = Recipe(title: "", ingredients: "", steps: "", image: "", recipetype: "", duration: "", difficulty: 1.0)
}

//
//  Recipe.swift
//  RecipesApp
//
//  Created by Mobile on 25/06/2023.
//
import SwiftUI
import Foundation

struct Recipe: Identifiable, Codable {
    
    var id: String
    var title : String
    var ingredients : String
    var steps : String
    var image : String
    var recipetype : String
    var duration : String
    var difficulty: Double
    
    init(id: String = UUID().uuidString, title: String, ingredients: String, steps: String, image: String, recipetype: String, duration: String, difficulty: Double){
        self.id = id
        self.title = title
        self.ingredients = ingredients
        self.steps = steps
        self.image = image
        self.recipetype = recipetype
        self.duration = duration
        self.difficulty = difficulty
    }
    
    func updateCompletion() -> Recipe {
        return Recipe(title: title, ingredients: ingredients, steps: steps, image: image, recipetype: recipetype, duration: duration, difficulty: difficulty)
    }
}

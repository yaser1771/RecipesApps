//
//  RecipeListViewModel.swift
//  RecipesApp
//
//  Created by Mobile on 25/06/2023.
//

import SwiftUI

class RecipeListViewModel: ObservableObject{
    @Published var recipeList: [Recipe] = []{
        didSet{
            saveData()
        }
    }
    
    let itemsKey: String = "Recipe_List"
    
    init(){
        getData()
    }
    
    func addRecipe(newRecipe: Recipe){
        recipeList.append(newRecipe)
    }
    
    func deleteRecipe(recipeIndex: IndexSet){
        recipeList.remove(atOffsets: recipeIndex)
    }
    
    func editRecipe(editedRecipe: Recipe){
        if let index = recipeList.firstIndex(where: {$0.id == editedRecipe.id}){
            recipeList[index] = editedRecipe.updateCompletion()
        }
    }
    
    func getData(){
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([Recipe].self, from: data)
        else{ return }
        
        if savedItems.isEmpty{
            self.recipeList = recipeData
        }
        else{
            self.recipeList = savedItems
        }
        
    }
    
    func saveData(){
        if let encodedData = try? JSONEncoder().encode(recipeList){
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
}

let recipeData = [
    Recipe(title: "Sunny side up with avocado", ingredients: "", steps: "", image: "dish1", recipetype: "", duration: "180 minutes", difficulty: 4.5 ),
    Recipe(title: "Sunny side up with avocado 2", ingredients: "", steps: "", image: "dish1", recipetype: "", duration: "60 minutes", difficulty: 4.5 ),
    Recipe(title: "Sunny side up with avocado 3", ingredients: "", steps: "", image: "dish1", recipetype: "", duration: "90 minutes", difficulty: 4.5 )
]

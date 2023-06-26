//
//  RecipeDetailViewModel.swift
//  RecipesApp
//
//  Created by Mobile on 26/06/2023.
//

import SwiftUI
import Combine

final class RecipeDetailViewModel: ObservableObject, Completeable, Navigable {
    
    let didComplete = PassthroughSubject<RecipeDetailViewModel, Never>()
    let didCompleteBack = PassthroughSubject<RecipeDetailViewModel, Never>()
    let itemsKey: String = "Recipe_List"
    
    @Published var newRecipe:Recipe = Recipe(title: "", ingredients: "", steps: "", image: "", recipetype: "", duration: "", difficulty: 1.0)
    @Published var recipeList: [Recipe] = []
    @Published var image: Image?
    @Published var currentRecipeIndex: Int = 0
    @Published var isDeleteSuccess = false
    
    init(index: Int) {
        UITextView.appearance().textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)   // << !!
        currentRecipeIndex = index
        getData()
    }
    
    func didTapNext(currentRecipe: Recipe) {
        didComplete.send(self)
    }
    
    func getData(){
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([Recipe].self, from: data)
        else{
            return
        }
        
        recipeList = savedItems
        newRecipe = recipeList[currentRecipeIndex]
        
        if newRecipe.image.isEmpty || newRecipe.image == "dish1"{
            newRecipe.image = "dish1"
            
            image = Image(newRecipe.image)
        }
        else{
            let newImage = UIImage(contentsOfFile: newRecipe.image)!
            image = Image(uiImage: newImage)
        }
    }
    
    func didGoBack() {
        didCompleteBack.send(self)
    }
    
    func deleteRecipe(){
        recipeList.remove(at: currentRecipeIndex)
        saveData()
        didGoBack()
    }
    
    func saveData(){
        if let encodedData = try? JSONEncoder().encode(recipeList){
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
}

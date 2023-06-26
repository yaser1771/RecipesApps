//
//  EditRecipeViewModel.swift
//  RecipesApp
//
//  Created by Mobile on 26/06/2023.
//

import SwiftUI
import Combine

final class EditRecipeViewModel: ObservableObject, Completeable, Navigable {
    
    let didComplete = PassthroughSubject<EditRecipeViewModel, Never>()
    let didCompleteBack = PassthroughSubject<EditRecipeViewModel, Never>()
    
    @Published var newRecipe:Recipe = Recipe(title: "", ingredients: "", steps: "", image: "", recipetype: "", duration: "", difficulty: 1.0)
    @Published var isSaveSuccess = false
    @Published var isSaveFailed = false
    @Published var isDeleteSuccess = false
    @Published var image: Image?
    @Published var inputImage: UIImage?
    @Published var imageFilename: String = ""
    @Published var processedImage: UIImage?
    @Published var recipeList: [Recipe] = []{
        didSet{
            saveData()
        }
    }
    
    let itemsKey: String = "Recipe_List"
    
    init(recipe: Recipe) {
        UITextView.appearance().textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)   // << !!
        newRecipe = recipe
        getData()
    }
    
    func getData(){
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([Recipe].self, from: data)
        else{
            return
        }
        
        recipeList = savedItems
        
        if newRecipe.image.isEmpty || newRecipe.image == "dish1"{
            newRecipe.image = "dish1"
            
            image = Image(newRecipe.image)
        }
        else{
            let newImage = UIImage(contentsOfFile: newRecipe.image)!
            image = Image(uiImage: newImage)
        }
    }
    
    func didTapNext() {
        didComplete.send(self)
    }
    
    func didGoBack() {
        didCompleteBack.send(self)
    }
    
    func editRecipe(editedRecipe: Recipe){
        if let index = recipeList.firstIndex(where: {$0.id == editedRecipe.id}){
            recipeList[index] = editedRecipe.updateCompletion()
            didGoBack()
        }
    }
    
    func saveData(){
        if let encodedData = try? JSONEncoder().encode(recipeList){
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        
        let imageData = inputImage.pngData()!
        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let imageURL = docDir.appendingPathComponent("recipeimage.png")
        try! imageData.write(to: imageURL)
        newRecipe.image = String(imageURL.path)
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}


//
//  AddRecipeViewModel.swift
//  RecipesApp
//
//  Created by Mobile on 25/06/2023.
//

import SwiftUI
import Combine

final class AddRecipeViewModel: ObservableObject, Completeable, Navigable {
    
    let didComplete = PassthroughSubject<AddRecipeViewModel, Never>()
    let didCompleteBack = PassthroughSubject<AddRecipeViewModel, Never>()
    
    @Published var newRecipe:Recipe = Recipe(title: "", ingredients: "", steps: "", image: "", recipetype: "", duration: "", difficulty: 1.0)
    @Published var isSaveSuccess = false
    @Published var isSaveFailed = false
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
    
    init() {
        UITextView.appearance().textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)   // << !!
        newRecipe.recipetype = "Breakfast"
    }
    
    func didTapNext() {
        didComplete.send(self)
    }
    
    func didGoBack() {
        didCompleteBack.send(self)
    }
    
    func addRecipe(newRecipe: Recipe){
        getData()
        //let recipeasd = recipeList
        recipeList.append(newRecipe)
    }
    
    
    func getData(){
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([Recipe].self, from: data)
        else{
            return
            
        }
        
        recipeList = savedItems
        
    }
    
    func deleteRecipe(recipeIndex: IndexSet){
        recipeList.remove(atOffsets: recipeIndex)
    }
    
    func editRecipe(editedRecipe: Recipe){
        if let index = recipeList.firstIndex(where: {$0.id == editedRecipe.id}){
            recipeList[index] = editedRecipe.updateCompletion()
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
        
//        let imageData = inputImage.pngData()!
//        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//        let imageURL = docDir.appendingPathComponent("recipeimage.png")
//        try! imageData.write(to: imageURL)
//        newRecipe.image = String(imageURL.path)
        
        let dir_path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("directory", isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: dir_path.path){
            do{
                try FileManager.default.createDirectory(atPath: dir_path.path , withIntermediateDirectories: true, attributes: nil)
                print("successfully saved")
            }
            catch{
                print("error creating directory" + error.localizedDescription)
            }
        }
        
        let img_dir = dir_path.appendingPathComponent("recipeimage.png")
        
        do{
            try self.inputImage?.pngData()?.write(to: img_dir)
            print("Saved")
        }
        catch{
            print("Error")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveRecipe(){
        
        //Save recipe
        if !newRecipe.title.isEmpty{
            
            addRecipe(newRecipe: newRecipe)
            isSaveSuccess = true
            didGoBack()
//            newRecipe = Recipe(title: "", ingredients: "", steps: "", image: "", recipetype: "Breakfast", duration: "", difficulty: 1.0)
        }
        else{
            
            isSaveFailed = true
        }
    }
    
}


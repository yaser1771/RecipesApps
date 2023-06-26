//
//  DashboardViewModel.swift
//  RecipesApp
//
//  Created by Mobile on 24/06/2023.
//

import SwiftUI
import Combine

final class DashboardViewModel: ObservableObject, Completeable, Navigable {
    
    @Published var recipeList: [Recipe] = []
    @Published var recipeListOri: [Recipe] = []
    @Published var recipeTypes = [[""]]
    @Published var currentIndex = 0
    @Published var currentIndexPicker = 0
    @Published var images: Image?
    
    let itemsKey: String = "Recipe_List"
    
    let didComplete = PassthroughSubject<DashboardViewModel, Never>()
    let didCompleteMore = PassthroughSubject<DashboardViewModel, Never>()
    
    init(){
        getData()
        getRecipeType()
        
        let imagePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("directory")
            .appendingPathComponent("recipeimage.png")
        
        //images = UIImage(contentsOfFile: imagePath.path)!
    }
    
    func didTapAdd() {
        didComplete.send(self)
    }
    
    func didTapMore(index:Int) {
        currentIndex = index
        didCompleteMore.send(self)
    }
    
    func filterRecipeList(index: Int){
        let recipeType = self.recipeTypes[0][index]
        
        if recipeType == "Show All"{
            recipeList = recipeListOri
        }
        else{
            recipeList = recipeListOri.filter { $0.recipetype == recipeType }
        }
        
    }
    
    func getData(){
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([Recipe].self, from: data)
        else{
            recipeList = recipeData1
            recipeListOri = recipeData1
            saveData()
            return
            
        }
        
        if data.isEmpty || savedItems.isEmpty{
            recipeList = recipeData1
        }
        else{
            recipeList = savedItems
            recipeListOri = savedItems
        }
        
    }
    
    func saveData(){
        if let encodedData = try? JSONEncoder().encode(recipeList){
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    func getRecipeType(){
        if let url = Bundle.main.url(forResource: "recipetypes", withExtension: "xml") {
            do {
                let data = try Data(contentsOf: url)
                let parser = XmlParser(data: data)
                
                if parser.parse() {
                    if !parser.itemList.isEmpty{
                        let typesXML = parser.itemList
                        recipeTypes = [typesXML]
                    }
                }
                else {
                    print("\n---> parser error: \(parser.parserError as Optional)")
                }
                
            }
            catch {
                print("\n---> data error: \(error)")
            }
        }
    }
    
}

let recipeData1 = [
    Recipe(title: "Sunny side up with avocado", ingredients: "123", steps: "123", image: "dish1", recipetype: "Breakfast", duration: "180 minutes", difficulty: 4.5 ),
    Recipe(title: "Sunny side up with avocado", ingredients: "123", steps: "123", image: "dish1", recipetype: "Snack", duration: "20 minutes", difficulty: 4.5 ),
    Recipe(title: "Sunny side up with avocado 2", ingredients: "123", steps: "123", image: "dish1", recipetype: "Lunch", duration: "60 minutes", difficulty: 4.5 ),
    Recipe(title: "Sunny side up with avocado 3", ingredients: "123", steps: "123", image: "dish1", recipetype: "Lunch", duration: "50 minutes", difficulty: 4.5 ),
    Recipe(title: "Sunny side up with avocado 4", ingredients: "123", steps: "123", image: "dish1", recipetype: "Dinner", duration: "90 minutes", difficulty: 4.5 ),
    Recipe(title: "Sunny side up with avocado 5", ingredients: "123", steps: "123", image: "dish1", recipetype: "Dinner", duration: "90 minutes", difficulty: 4.5 )
]

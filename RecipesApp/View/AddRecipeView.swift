//
//  AddRecipeView.swift
//  RecipesApp
//
//  Created by Mobile on 25/06/2023.
//

import Foundation
import SwiftUI

struct AddRecipeView: View {
    
    @StateObject var vm = AddRecipeViewModel()
    @State private var orientation = UIDevice.current.orientation
    
    @State private var showingImagePicker = false
    
    @State private var recipeTypes = [""]
    
    var body: some View {
        
            ZStack{
                Color(red: 112 / 255, green: 171 / 255, blue: 111 / 255)
                
                ScrollView(.vertical){
                    
                VStack(alignment: .leading){
                    
                    Spacer()
                    
                    ZStack{
                        Rectangle()
                            .fill(.secondary)
                        
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        vm.image?
                            .resizable()
                            .scaledToFit()
                    }
//                    .frame(height: 200)
                    .cornerRadius(15)
                    .onTapGesture {
                        showingImagePicker = true
                    }
                    
                    TextField("Title", text: $vm.newRecipe.title)
                        .frame(height: 60)
                        .textFieldStyle(.roundedBorder)
                    
                    HStack{
                        
                        TextField("Duration (minutes)", text: $vm.newRecipe.duration)
                            .frame(height: 60)
                            .textFieldStyle(.roundedBorder)
                        
                        Picker("Select recipe type", selection: $vm.newRecipe.recipetype) {
                            ForEach(recipeTypes, id: \.self) {
                                Text($0)
                                    .foregroundColor(.white)
                            }
                        }
                        .foregroundColor(.white)
                        .background(.white)
                        .cornerRadius(10)
                        
                    }
                    
                    Text("Ingredient List :")
                        .foregroundColor(.white)
                    
                    TextEditor(text: $vm.newRecipe.ingredients)
                        .foregroundStyle(.secondary)
                        .cornerRadius(20)
                        .frame(height: 200)
                    
                    Text("Steps :")
                        .foregroundColor(.white)
                    
                    TextEditor(text: $vm.newRecipe.steps)
                        .foregroundStyle(.secondary)
                        .cornerRadius(15)
                        .frame(height: 300)
                    
                    Button(action: vm.saveRecipe, label: {
                        Text("Save".uppercased())
                            .foregroundColor(.white)
                            .font(.headline)
    //                        .frame(height: 50)
                            .frame(maxWidth: .infinity)
                    })
                    .alert(isPresented: $vm.isSaveSuccess) {
                        Alert(title: Text("Save successful"), message: Text(""), dismissButton: .default(Text("OK")))
                            }
                    .alert(isPresented: $vm.isSaveFailed) {
                        Alert(title: Text("Save failed"), message: Text("Enter recipe title"), dismissButton: .default(Text("OK")))
                            }
                    .padding()
                    .buttonStyle(.borderedProminent)
                    .controlSize(/*@START_MENU_TOKEN@*/.large/*@END_MENU_TOKEN@*/)
                    .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                }
        }
        .onAppear {
        if let url = Bundle.main.url(forResource: "recipetypes", withExtension: "xml") {
            do {
                let data = try Data(contentsOf: url)
                let parser = XmlParser(data: data)
                
                if parser.parse() {
                    if !parser.itemList.isEmpty{
                        let typesXML = parser.itemList
                        recipeTypes = typesXML
                        recipeTypes.removeFirst()
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
        .navigationViewStyle(StackNavigationViewStyle())
        .onChange(of: vm.inputImage) { _ in vm.loadImage() }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $vm.inputImage)
        }
    }
    
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}

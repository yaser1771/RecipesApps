//
//  RecipeDetailView.swift
//  RecipesApp
//
//  Created by Mobile on 26/06/2023.
//

import Foundation
import SwiftUI

struct RecipeDetailView: View {
    
    @StateObject var vm = RecipeDetailViewModel(index: 0)
    @State private var orientation = UIDevice.current.orientation
    
    @State private var showingImagePicker = false
    
    @State private var recipeTypes = [""]
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing){
                Color(red: 23 / 255, green: 67 / 255, blue: 111 / 255)
                
                ScrollView(.vertical){
                    
                VStack(alignment: .center){
                    
                    Spacer()
                    
                    ZStack(alignment: .center){
                        vm.image?
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(width: 200, height: 200)
                    .cornerRadius(15)
                    .multilineTextAlignment(.center)
                    
                    
                    TextField("", text: $vm.newRecipe.title)
                        .frame(height: 60)
                        .textFieldStyle(.roundedBorder)
                        .disabled(true)
                    
                    HStack{
                        
                        TextField("", text: $vm.newRecipe.duration)
                            .frame(height: 60)
                            .textFieldStyle(.roundedBorder)
                            .disabled(true)
                        
                        TextField("", text: $vm.newRecipe.recipetype)
                            .frame(height: 60)
                            .textFieldStyle(.roundedBorder)
                            .disabled(true)
                        
                    }
                    
                    Text("Ingredient List :")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextEditor(text: $vm.newRecipe.ingredients)
                        .foregroundStyle(.secondary)
                        .cornerRadius(20)
                        .frame(height: 200)
                        .disabled(true)
                    
                    Text("Steps :")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextEditor(text: $vm.newRecipe.steps)
                        .foregroundStyle(.secondary)
                        .cornerRadius(15)
                        .frame(height: 300)
                        .disabled(true)
                    
                    HStack{
                        Button(action: vm.deleteRecipe, label: {
                            Text("Delete".uppercased())
                                .foregroundColor(.white)
                                .font(.headline)
        //                        .frame(height: 50)
                                .frame(maxWidth: .infinity)
                        })
                        .padding()
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                        .controlSize(/*@START_MENU_TOKEN@*/.large/*@END_MENU_TOKEN@*/)
                        .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                        .alert(isPresented: $vm.isDeleteSuccess) {
                            Alert(title: Text("Delete successful"), message: Text(""), dismissButton: .default(Text("OK"), action: {
                            }))
                                }
                        
                        Button(action: {
                            vm.didTapNext(currentRecipe: vm.newRecipe)
                        }, label: {
                            Text("Edit".uppercased())
                                .foregroundColor(.white)
                                .font(.headline)
        //                        .frame(height: 50)
                                .frame(maxWidth: .infinity)
                        })
                        .padding()
                        .buttonStyle(.borderedProminent)
                        .controlSize(/*@START_MENU_TOKEN@*/.large/*@END_MENU_TOKEN@*/)
                        .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
                .onAppear(){
                    vm.getData()
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView()
    }
}

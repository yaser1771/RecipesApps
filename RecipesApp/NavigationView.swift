//
//  NavigationView.swift
//  RecipesApp
//
//  Created by Mobile on 24/06/2023.
//

import SwiftUI

struct NavigationView: View {
    
    @StateObject var vm: NavigationViewModel

    var body: some View {
        NavigationStack(path: $vm.navigationPath) {
            VStack() {
                WelcomeView(vm: vm.makeScreenWelcomeVM())
            }
            .navigationDestination(for: Screen.self) {screen in
                switch screen {
                case .screen2(vm: let vm):
                    LoginView(vm: vm)
                        .navigationBarBackButtonHidden()
                case .screen3(vm: let vm):
                    DashboardView(vm: vm)
                        .navigationBarBackButtonHidden()
                        .navigationTitle("My Recipe")
                case .screen4(vm: let vm):
                    AddRecipeView(vm: vm)
                        .navigationTitle("Add Recipe")
                case .screen5(vm: let vm):
                    RecipeDetailView(vm: vm)
                        .navigationTitle("Recipe Details")
                case .screen6(vm: let vm):
                    EditRecipeView(vm: vm)
                        .navigationTitle("Edit Recipe")
                }
            }
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

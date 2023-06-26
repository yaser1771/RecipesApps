//
//  LoginViewModel.swift
//  RecipesApp
//
//  Created by Mobile on 24/06/2023.
//

import SwiftUI
import Combine

final class LoginViewModel: ObservableObject, Completeable, Navigable {
    
    @AppStorage("AUTH_KEY") var authenticated = false{
            willSet{ objectWillChange.send()}
        }
    @Published var username = ""
    @Published var password = ""
    @Published var invalid:Bool = false
    @Published var errorMessage:String = ""
    
    let didComplete = PassthroughSubject<LoginViewModel, Never>()
    
    func authenticate(){
        
        errorMessage = String("")//reset error message
        
        guard !self.username.lowercased().isEmpty else{
            errorMessage += String("Enter your username")
            self.invalid = true
            return
        }
        
        guard !self.password.lowercased().isEmpty else{
            errorMessage += String("Enter your password")
            self.invalid = true
            return
        }
        
        didComplete.send(self)
    }
    
    func didTapNext() {
        didComplete.send(self)
    }
}

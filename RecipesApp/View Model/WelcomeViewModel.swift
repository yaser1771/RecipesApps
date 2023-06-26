//
//  WelcomeViewModel.swift
//  RecipesApp
//
//  Created by Mobile on 24/06/2023.
//

import SwiftUI
import Combine

final class WelcomeViewModel: ObservableObject, Completeable {
    
    let didComplete = PassthroughSubject<WelcomeViewModel, Never>()

    func didTapNext() {
        didComplete.send(self)
    }
}

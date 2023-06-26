//
//  NavigationViewModel.swift
//  RecipesApp
//
//  Created by Mobile on 24/06/2023.
//

import Foundation
import Combine
import SwiftUI

protocol Completeable {
    var didComplete: PassthroughSubject<Self, Never> { get }
}

protocol Navigable: AnyObject, Identifiable, Hashable {}

extension Navigable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum Screen: Hashable {
    case screen2(vm: LoginViewModel)
    case screen3(vm: DashboardViewModel)
    case screen4(vm: AddRecipeViewModel)
    case screen5(vm: RecipeDetailViewModel)
    case screen6(vm: EditRecipeViewModel)
}

class NavigationViewModel: ObservableObject {
    
    // Note the final model is manually "bound" to the view models here.
    // Automatic binding would be possible with combine or even a single VM.
    // However this may not scale well
    // and the views become dependant on something that is external to the view.
    private let model: Model
    var subscription = Set<AnyCancellable>()
    
    @Published var navigationPath: [Screen] = []
    
    init() {
        self.model = Model()
    }

    func makeScreenWelcomeVM() -> WelcomeViewModel {
        let vm = WelcomeViewModel()
        vm.didComplete
            .sink(receiveValue: didCompleteWelcomeVM)
            .store(in: &subscription)
        return vm
    }

    func didCompleteWelcomeVM(vm: WelcomeViewModel) {
        // Additional logic inc. updating model
        navigationPath.append(.screen2(vm: makeScreenLoginVM()))
    }
    
    func makeScreenLoginVM() -> LoginViewModel {
        let vm = LoginViewModel()
        vm.didComplete
            .sink(receiveValue: didCompleteLoginVM)
            .store(in: &subscription)
        return vm
    }

    func didCompleteLoginVM(vm: LoginViewModel) {
        // Additional logic inc. updating model
        navigationPath.append(.screen3(vm: makeScreenDashboardVM()))
    }
    
    func makeScreenDashboardVM() -> DashboardViewModel {
        let vm = DashboardViewModel()
        vm.didComplete
            .sink(receiveValue: didCompleteDashboardVM)
            .store(in: &subscription)
        vm.didCompleteMore
            .sink(receiveValue: didCompleteDashboardMoreVM)
            .store(in: &subscription)
        return vm
    }

    func didCompleteDashboardVM(vm: DashboardViewModel) {
        // Additional logic inc. updating model
        navigationPath.append(.screen4(vm: makeScreenAddRecipeVM()))
    }
    
    func didCompleteDashboardMoreVM(vm: DashboardViewModel) {
        // Additional logic inc. updating model
        model.index = vm.currentIndex
        navigationPath.append(.screen5(vm: makeScreenRecipeDetailVM()))
    }
    
    func makeScreenAddRecipeVM() -> AddRecipeViewModel {
        let vm = AddRecipeViewModel()
        vm.didComplete
            .sink(receiveValue: didCompleteAddRecipeVM)
            .store(in: &subscription)
        vm.didCompleteBack
            .sink(receiveValue: didGoBackVM)
            .store(in: &subscription)
        return vm
    }
    
    func didGoBackVM(vm: AddRecipeViewModel) {
           navigationPath.removeLast()
    }
    
    func didCompleteAddRecipeVM(vm: AddRecipeViewModel) {
        // Additional logic inc. updating model
//        navigationPath.append(.screen2(vm: makeScreen2VerificationVM()))
    }
    
    func makeScreenRecipeDetailVM() -> RecipeDetailViewModel {
        let vm = RecipeDetailViewModel(index: model.index)
        vm.didComplete
            .sink(receiveValue: didCompleteRecipeDetailVM)
            .store(in: &subscription)
        vm.didCompleteBack
            .sink(receiveValue: didGoBackVM)
            .store(in: &subscription)
        return vm
    }

    func didCompleteRecipeDetailVM(vm: RecipeDetailViewModel) {
        // Additional logic inc. updating model
        model.recipe = vm.newRecipe
        navigationPath.append(.screen6(vm: makeScreenEditRecipeVM()))
    }
    
    func didGoBackVM(vm: RecipeDetailViewModel) {
           navigationPath.removeLast()
    }
    
    func makeScreenEditRecipeVM() -> EditRecipeViewModel {
        let vm = EditRecipeViewModel(recipe: model.recipe)
        vm.didComplete
            .sink(receiveValue: didCompleteEditRecipeVM)
            .store(in: &subscription)
        vm.didCompleteBack
            .sink(receiveValue: didGoBackVM)
            .store(in: &subscription)
        return vm
    }
    
    func didGoBackVM(vm: EditRecipeViewModel) {
           navigationPath.removeLast()
    }
    
    func didCompleteEditRecipeVM(vm: EditRecipeViewModel) {
        // Additional logic inc. updating model
//        navigationPath.append(.screen2(vm: makeScreen2VerificationVM()))
    }
    
}

//
//  WelcomeView.swift
//  RecipesApp
//
//  Created by Mobile on 24/06/2023.
//

import SwiftUI

struct WelcomeView: View{
    
    @StateObject var vm = WelcomeViewModel()
    @State private var orientation = UIDevice.current.orientation
    
    var body: some View{
        
        ZStack {
            
            Image("recipe_bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
        VStack{
            
            if orientation.isPortrait{
                Spacer(minLength: 190)
            }
            
            Text("Cooking Experience \nLike a Chef")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Spacer()
                .frame(height: 10)
            
            Text("Let's make a delicious dish with \nthe best recipe for the family")
                .font(.body)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Spacer()
                .frame(height: 50)
            
            Button("Get Started", action: {
                self.vm.didTapNext()
            })
            .foregroundColor(.white)
            .padding()
            .buttonStyle(.borderedProminent)
            .controlSize(/*@START_MENU_TOKEN@*/.large/*@END_MENU_TOKEN@*/)
            .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
            
        }//VStack
        .scaledToFit()
            
        }//ZStack
        .multilineTextAlignment(.center)
        .detectOrientation($orientation)
        .onAppear(){
            orientation = UIDeviceOrientation.portrait
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

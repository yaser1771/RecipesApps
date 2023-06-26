//
//  HomeView.swift
//  RecipesApp
//
//  Created by Mobile on 24/06/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var vm = HomeViewModel()
    
    var body: some View {
        
        VStack{
            
            Spacer()
            
            HStack(){
                
                Image("account")
                    .resizable()
                    .frame(width: 50, height: 50)
                
                
                VStack(alignment:.leading){
                    
                    Text("Good Morning,")
                        .font(.body)
                    
                    Text("Username")
                        .font(.title.bold())
                }
                
                Spacer()
                
            }
            .padding()
            .background(.mint)
            .cornerRadius(15)
            .frame(width: 300)
            
            Spacer()
        }
        .scaledToFit()
        
    }
}
 
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

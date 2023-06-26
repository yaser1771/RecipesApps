//
//  LoginView.swift
//  RecipesApp
//
//  Created by Mobile on 24/06/2023.
//

import SwiftUI

struct LoginView: View{
    
    @StateObject var vm = LoginViewModel()
    @State private var orientation = UIDevice.current.orientation
    
    var body: some View{
        
        ZStack {
            
            Image("cutterboard")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
        VStack{
            
            if orientation.isPortrait{
                Spacer()

                Image("cook_book")
                    .resizable()
                    .frame(width: 150, height: 150)

                Text("My Recipes")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .bold()
                    .foregroundColor(.black)
                    .padding()
                    .background(.white)
                    .cornerRadius(15)

                Spacer()

                VStack{

                    TextField("Username", text: $vm.username)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .frame(height: 50)

                    SecureField("Password", text: $vm.password)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .frame(height: 50)
                        .privacySensitive()
                }

                Spacer()
                    .frame(height: 50)

                Button("Login", action: vm.authenticate)
                .foregroundColor(.white)
                .padding()
                .buttonStyle(.borderedProminent)
                .controlSize(/*@START_MENU_TOKEN@*/.large/*@END_MENU_TOKEN@*/)
                .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                
                Button("Login as Guest", action: vm.didTapNext)
                .foregroundColor(.white)
                .underline()
            }//Portrait END
            
            if orientation.isLandscape{
                HStack{
                    
                    VStack{
                        
                        Image("cook_book")
                            .resizable()
                            .frame(width: 150, height: 150)
                        
                        Text("My Recipes")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.center)
                            .bold()
                            .foregroundColor(.black)
                            .padding()
                            .background(.white)
                            .cornerRadius(15)
                    }
                    
                    Spacer()
                    
                    VStack{
                        
                        TextField("Username", text: $vm.username)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                            .frame(height: 50)
                        
                        SecureField("Password", text: $vm.password)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                            .frame(height: 50)
                            .privacySensitive()
                        
                        Button("Login", action: vm.authenticate)
                        .foregroundColor(.white)
                        .padding()
                        .buttonStyle(.borderedProminent)
                        .controlSize(/*@START_MENU_TOKEN@*/.large/*@END_MENU_TOKEN@*/)
                        .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                        
                        Button("Login as Guest", action: vm.didTapNext)
                        .foregroundColor(.white)
                        .underline()
                    }
                }
                .frame(width: 600, height: 350)
            }//Landscape END
            
            
        }//VStack
        .scaledToFit()
        .alert(isPresented: $vm.invalid) {
            Alert(title: Text("Access Denied"), message: Text(self.vm.errorMessage),
                  dismissButton: .default(Text("OK")))
        }
        .frame(width: 300)
        .padding()
        .detectOrientation($orientation)
        .onAppear(){
            orientation = UIDeviceOrientation.portrait
        }
            
        }//ZStack
        .multilineTextAlignment(.center)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
//            .previewInterfaceOrientation(.landscapeRight)
    }
}

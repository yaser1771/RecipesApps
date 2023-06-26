//
//  DashboardView.swift
//  RecipesApp
//
//  Created by Mobile on 24/06/2023.
//

import SwiftUI

struct DashboardView: View {
    
    @StateObject var vm = DashboardViewModel()
    @State private var orientation = UIDevice.current.orientation
    
    private let columnCount:Int = 2
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing){
            Color(red: 116 / 255, green: 107 / 255, blue: 169 / 255)
            
            VStack{
                
                GroupBox{
                    
                    CustomPicker(dataArrays: $vm.recipeTypes, currentSelectedIndex: $vm.currentIndexPicker)
                        .onChange(of: vm.currentIndexPicker) { newValue in
                            
                            print("selected index \(vm.currentIndexPicker)")
                            
                            vm.filterRecipeList(index: vm.currentIndexPicker)
                        }
                        .frame(height: 150)
                    
                    Spacer(minLength: 10)
                    
                    Grid(itemSize: vm.recipeList.count,
                         columns: 2,
                         rowSpacing: 10,
                         columnSpacing: 10){ (index) in
                        
                        GroupBox{
                            VStack(alignment: .leading){
                                
//                                vm.images?
//                                    .resizable()
//                                    .scaledToFit()
//                                    .cornerRadius(10)
                                
//                                let bundlePath = Bundle.main.path(forResource: "recipeimage", ofType: "png")
//                                let image = UIImage(contentsOfFile: bundlePath!)
//                                let stsr = "file:///Users/mobile/Library/Developer/CoreSimulator/Devices/F588DC2C-CD2C-4603-AB55-7035D6BF7C5C/data/Containers/Data/Application/94AE580C-7FAA-4ACE-85C2-2247B82C0BC6/Documents/recipeimage.png"
//                                let asd = vm.recipeList[index].image
//                                let newString = asd.replacingOccurrences(of: "file://", with: "")
//                                let newImage = UIImage(contentsOfFile: vm.recipeList[index].image)!
//                                Image(uiImage: newImage)
                                Image("dish1")
//                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10)
                                
                                Text(vm.recipeList[index].title)
                                    .font(.subheadline)
                                    .bold()
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                                
                                HStack(){
                                    Text(vm.recipeList[index].duration)
                                        .font(.footnote)
                                        .multilineTextAlignment(.leading)
                                    
                                    Spacer()
                                    
                                    Button("more.."){
                                        vm.didTapMore(index: index)
                                    }
                                    .font(.footnote)
                                }
                            }
                        }
                        
                    }
                    
                    Spacer()
                }
                .padding()
            }
            
            Button( action: vm.didTapAdd, label: {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(Color(red: 116 / 255, green: 107 / 255, blue: 169 / 255))
                    .font(.system(size: 40))
            })
            .padding()
        }
        .onAppear(){
            vm.getData()
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
//            .environmentObject(Order())
    }
}

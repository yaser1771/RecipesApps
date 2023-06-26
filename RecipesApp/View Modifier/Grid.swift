//
//  Grid.swift
//  RecipesApp
//
//  Created by Mobile on 25/06/2023.
//

import SwiftUI

struct Grid<Content:View> : View {
    
    let itemSize: Int
    let columns: Int
    let rowSpacing: CGFloat
    let columnSpacing: CGFloat
    let content:(Int) -> Content
    
    var body: some View {
        let rows = (Double(self.itemSize) / Double(self.columns)).rounded(.up)
        
        GeometryReader { geometry in
            let totalColumnSpacing = CGFloat(self.columns - 1) * self.columnSpacing
            let columnWidth = (geometry.size.width - totalColumnSpacing) / CGFloat(self.columns)
            
            ScrollView(.vertical){
                ForEach(0..<Int(rows)) {row in
                    Spacer(minLength: self.rowSpacing)
                    HStack(spacing: columnSpacing){
                        ForEach(0..<self.columns){ column in
                            let index = row * self.columns + column
                            
                            if index < self.itemSize{
                                self.content(index).frame(width: columnWidth)
                            }
                            else {
                                Spacer().frame(width: columnWidth)
                            }
                        }
                    }
                }
            }
            
        }
    }
    
}


struct Grid_Previews: PreviewProvider{
    static var previews: some View{
        Grid(itemSize: 4, columns: 2, rowSpacing: 5, columnSpacing: 5){
            index in
            Text("\(index)")
        }
    }
}

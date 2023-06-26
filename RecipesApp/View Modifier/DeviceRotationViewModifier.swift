//
//  DeviceRotationViewModifier.swift
//  RecipesApp
//
//  Created by Mobile on 24/06/2023.
//

import SwiftUI

struct DeviceRotationViewModifier : ViewModifier{
    
//    let action: (UIDeviceOrientation) -> Void
    @Binding var orientation: UIDeviceOrientation
    
    func body(content: Content) -> some View {
        content
            .onAppear(){
//                orientation = UIDeviceOrientation.portrait
            }
            .onReceive(NotificationCenter.default.publisher(for:UIDevice.orientationDidChangeNotification)) {
                _ in orientation = UIDevice.current.orientation
//                _ in action(UIDevice.current.orientation)
            }
    }
}

extension View{
//    func onRotate(perform action: @escaping (UIDeviceOrientation)-> Void) -> some View{
//        self.modifier(DeviceRotationViewModifier(action: action))
//    }
    
    func onRotate(perform orientation: Binding<UIDeviceOrientation>) -> some View{
        self.modifier(DeviceRotationViewModifier(orientation: orientation))
    }
    
    func detectOrientation(_ orientation: Binding<UIDeviceOrientation>) -> some View{
        self.modifier(DeviceRotationViewModifier(orientation: orientation))
    }
}

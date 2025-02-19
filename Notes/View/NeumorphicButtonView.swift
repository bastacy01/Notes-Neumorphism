//
//  NeumorphicButtonView.swift
//  Notes
//
//  Created by Ben Stacy on 1/31/25.
//

import SwiftUI

struct NeumorphicButtonView: View {
    let imageName = ["power","chevron.left","chevron.right","speaker.fill","speaker.wave.2.fill","speaker.slash.fill"]
    var body: some View {
        ZStack {
            Color(red: 224/255, green: 229/255, blue: 236/255)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Button {
                    
                } label: {
                    Image(systemName: imageName[0])
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.gray)
                        .frame(width: 80, height: 80)
                        .neumorphic()
                }
            }
        }
    }
}

struct NeumorphicModifier: ViewModifier {
    var cornerRadius: CGFloat
    var backgroundColor: Color
    func body(content: Content) -> some View {
        content
            .padding()
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .shadow(color: Color.white.opacity(0.6), radius: 10, x: -10, y: -10)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
    }
}

extension View {
    func neumorphic(cornerRadius: CGFloat = 20, backgroundColor: Color = Color(red: 250/255, green: 250/255, blue: 250/255)) -> some View {
        self.modifier(
            NeumorphicModifier(
                cornerRadius: cornerRadius,
                backgroundColor: backgroundColor
            )
        )
    }
}

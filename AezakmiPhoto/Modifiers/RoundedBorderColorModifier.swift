//
//  RoundedBorderColorModifier.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 16.09.2024.
//

import SwiftUI

struct RoundedBorderColor: ViewModifier {
    var borderColor: Color
    var lineWidth: CGFloat
    var cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .inset(by: 0.25)
                    .stroke(borderColor, lineWidth: lineWidth)
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }
}


extension View {
    /// Border line width is `0.5` and cornerRadius is `8`
    func roundedBorderColor(_ color: Color, lineWidth: CGFloat = 0.5, cornerRadius: CGFloat = 18) -> some View {
        modifier(RoundedBorderColor(borderColor: color, lineWidth: lineWidth, cornerRadius: cornerRadius))
    }
}

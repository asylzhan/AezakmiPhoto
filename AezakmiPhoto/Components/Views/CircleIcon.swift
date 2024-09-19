//
//  CircleIcon.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 19.09.2024.
//

import SwiftUI

struct CircleIcon: View {
    
    var systemName: String
    var disabled: Bool = false
    var hidden: Bool = false
    
    var body: some View {
        Image(systemName: systemName)
           .frame(width: 36, height: 36)
           .foregroundColor(hidden ? Color.darkHighlight : disabled ? .gray : .white)
           .background(disabled ? Color(red: 44/255, green: 44/255, blue: 44/255) : Color.darkHighlight)
           .clipShape(Circle())
    }
}

//
//  TextInputRow.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 17.09.2024.
//

import SwiftUI

struct TextInputRow: View {
    var labelText: String
    var textFieldPlaceholder: String
    var keyboardType: UIKeyboardType = .default
    var isSecureField: Bool = false
    
    @Binding var textFieldContent: String

    var body: some View {
        Group {
            if isSecureField {
                SecureField(textFieldPlaceholder, text: $textFieldContent)
                    .frame(height: 46)
                    .padding(.leading)
                    .background(.lightPurple)
                    .roundedBorderColor(.gray, cornerRadius: 23)
            } else {
                TextField(textFieldPlaceholder, text: $textFieldContent)
                    .frame(height: 46)
                    .padding(.leading)
                    .keyboardType(keyboardType)
                    .background(.lightPurple)
                    .roundedBorderColor(.gray, cornerRadius: 23)
            }
        }
    }
}

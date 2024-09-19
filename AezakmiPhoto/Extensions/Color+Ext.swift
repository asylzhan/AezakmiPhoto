//
//  Color+Ext.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 19.09.2024.
//

import SwiftUI

extension Color {
    /// Main background color
    static let dark = Color(red: 35.0/255.0, green: 34.0/255.0, blue: 35.0/255.0)
    
    /// Main foreground color
    static let light = Color(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0)
    
    /// Color used for views background which is differ from main background
    static let darkHighlight = Color(red: 44.0/255.0, green: 44.0/255.0, blue: 44.0/255.0)
    
    static let permissionsBackground = Color(red: 29.0/255.0, green: 28.0/255.0, blue: 30.0/255.0)
}

extension UIColor {
    /// Main background color
    static let dark = UIColor(red: 35.0/255.0, green: 34.0/255.0, blue: 35.0/255.0, alpha: 1.0)
    
    /// Main foreground color
    static let light = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)
}

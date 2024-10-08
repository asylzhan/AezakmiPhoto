//
//  TextLabel.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 19.09.2024.
//

import SwiftUI

class TextLabel: UILabel {
    
    let padding = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    
    var styledLayer: CALayer!
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let width = size.width + padding.left + padding.right
        let heigth = size.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
}

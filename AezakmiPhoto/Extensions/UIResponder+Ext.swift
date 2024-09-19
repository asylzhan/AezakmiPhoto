//
//  UIResponder+Ext.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 19.09.2024.
//

import UIKit

extension UIResponder {
    public var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}

//
//  CanvasView.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 19.09.2024.
//

import SwiftUI
import PencilKit

struct CanvasView<T: PKCanvasView>: UIViewControllerRepresentable {
    typealias UIViewControllerType = CanvasViewController<T>
    
    /// PKCanvasView object
    @Binding var canvas: T
    
    /// Canvas drawing changed
    var onChanged: ((PKDrawing) -> Void)?
    
    /// Selected subview changed
    var onSelectionChanged: ((UIView?) -> Void)?
    
    /// Set as main responder for UIWindow
    var shouldBecameFirstResponder: Bool = true
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        CanvasViewController(
            canvas: canvas,
            onChanged: onChanged,
            onSelectionChanged: onSelectionChanged,
            shouldBecameFirstResponder: shouldBecameFirstResponder
        )
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}

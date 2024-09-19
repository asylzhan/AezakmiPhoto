//
//  PhotoPicker.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 19.09.2024.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PhotoPicker
        
        init(parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            // Check if there's an item provider and it can load UIImage
            if let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, error in
                    if let selectedImage = image as? UIImage {
                        DispatchQueue.main.async {
                            self.parent.selectedImage = selectedImage
                        }
                    }
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images // Only allow images to be picked
        config.selectionLimit = 1 // Limit the selection to one image
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
}

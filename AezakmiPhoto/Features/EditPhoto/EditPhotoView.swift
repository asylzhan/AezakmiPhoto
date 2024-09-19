//
//  EditPhotoView.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 17.09.2024.
//

import SwiftUI
import PencilKit

struct EditPhotoView: View {
    @StateObject var viewModel: EditPhotoViewModel
    @State private var showOptions = false
    @State private var showCamera = false
    @State private var showPhotoLibrary = false
    @State private var selectedImage: UIImage?
//    @State var selectedItem: MediaItem?
    
    var body: some View {
        NavigationStack {
            VStack {
                if let selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFill()
                        .padding()
                } else {
                    Text("Select image from settings options")
                        .padding()
                }
                Spacer()
                HStack {
                    if let selectedImage {
                        NavigationLink {
                            EditorView(media: MediaItem(type: .image, image: selectedImage, video: nil, videoUrl: nil)) {
                            }
                        } label: {
                            Image(systemName: "pencil.tip.crop.circle")
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    
                }
                .frame(height: 24)
            }
            .navigationTitle("Фото")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showOptions = true
                    } label: {
                        Image(systemName: "gear")
                    }
                    .confirmationDialog("Settings", isPresented: $showOptions) {
                        Button("Камера") {
                            showCamera = true
                        }
                        
                        Button("Выбрать фотографии") {
                            showPhotoLibrary = true
                        }
                        Button("Выйти", role: .destructive) {
                            Task {
                                await viewModel.signOut()
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showCamera) {
                CameraView(capturedImage: $selectedImage)
            }
            .sheet(isPresented: $showPhotoLibrary) {
                PhotoPicker(selectedImage: $selectedImage)
            }
        }
    }
    
}

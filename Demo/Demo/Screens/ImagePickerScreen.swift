//
//  ImagePickerScreen.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-10.
//

import PickerKit
import QuickLook
import SwiftUI

struct ImagePickerScreen: View {

    @State private var isPickerPresented = false
    @State private var images: [UIImage] = []

    var body: some View {
        List {
            Section("Images") {
                if images.isEmpty {
                    Text("None")
                }
                ForEach(Array(images.enumerated()), id: \.offset) { item in
                    Image(uiImage: item.element)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 150)
                }
                .onDelete { index in
                    images.remove(atOffsets: index)
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            Button("Pick Images") {
                isPickerPresented = true
            }
            .buttonStyle(.borderedProminent)
        }
        .fullScreenCover(isPresented: $isPickerPresented) {
            ImagePicker(
                sourceType: .photoLibrary,
                isPresented: $isPickerPresented,
                pickerConfig: { picker in },
                action: { result in
                    switch result {
                    case .cancelled: break
                    case .failure: break
                    case .success(let image): images.append(image)
                    }
                }
            )
            .ignoresSafeArea()
        }
        .navigationTitle("Document Scanner")
    }
}

#Preview {
    ImagePickerScreen()
}

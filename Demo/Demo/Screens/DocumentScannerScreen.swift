//
//  DocumentScannerScreen.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-10.
//

import PickerKit
import QuickLook
import SwiftUI

struct DocumentScannerScreen: View {

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
            Button("Scan Documents") {
                isPickerPresented = true
            }
            .buttonStyle(.borderedProminent)
        }
        .fullScreenCover(isPresented: $isPickerPresented) {
            DocumentScanner(
                isPresented: $isPickerPresented,
                action: { result in
                    switch result {
                    case .cancelled: break
                    case .failure: break
                    case .success(let scan): images += scan.images
                    }
                }
            )
            .ignoresSafeArea()
        }
        .navigationTitle("Document Scanner")
    }
}

#Preview {
    DocumentScannerScreen()
}

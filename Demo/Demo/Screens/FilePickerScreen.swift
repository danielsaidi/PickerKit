//
//  FilePickerScreen.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-10.
//

import PickerKit
import QuickLook
import SwiftUI

struct FilePickerScreen: View {

    @State private var quickLookUrl: URL?
    @State private var isPickerPresented = false
    @State private var urls: [URL] = []

    var body: some View {
        List {
            Section("Picked files") {
                if urls.isEmpty {
                    Text("None")
                }
                ForEach(Array(urls.enumerated()), id: \.offset) { item in
                    LabeledContent("File \(item.offset + 1)") {
                        Button {
                            quickLookUrl = item.element
                        } label: {
                            Label("Preview", systemImage: "eye")
                                .labelStyle(.iconOnly)
                        }
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            Button("Pick Files") {
                isPickerPresented = true
            }
            .buttonStyle(.borderedProminent)
        }
        .fullScreenCover(isPresented: $isPickerPresented) {
            FilePicker(
                documentTypes: [.content],
                isPresented: $isPickerPresented,
                pickerConfig: { picker in
                    picker.allowsMultipleSelection = true
                },
                action: { result in
                    switch result {
                    case .cancelled: break
                    case .failure: break
                    case .success(let urls): self.urls = urls
                    }
                }
            )
            .ignoresSafeArea()
        }
        .quickLookPreview($quickLookUrl)
        .navigationTitle("File Picker")
    }
}

#Preview {
    FilePickerScreen()
}

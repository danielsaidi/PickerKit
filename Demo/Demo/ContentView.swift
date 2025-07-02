//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Colors") {
                    NavigationLink("Color Picker Bar") {
                        ColorPickerBarScreen()
                    }
                }
                Section("Files") {
                    NavigationLink("File Picker") {
                        FilePickerScreen()
                    }
                }
                Section("Fonts") {
                    NavigationLink("Font Picker") {
                        FontPickerScreen()
                    }
                }
                Section("Images") {
                    NavigationLink("Camera") {
                        CameraScreen()
                    }
                    NavigationLink("Document Scanner") {
                        DocumentScannerScreen()
                    }
                    NavigationLink("Image Picker") {
                        ImagePickerScreen()
                    }
                }
                Section("General") {
                    NavigationLink("ForEach Picker") {
                        ForEachPickerScreen()
                    }
                    NavigationLink("Multi Picker") {
                        MultiPickerScreen()
                    }
                }
            }
            .navigationTitle("Picker Kit")
        }
    }
}

#Preview {
    ContentView()
}
